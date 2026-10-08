; DynamicWindowInstanceSwitcher.ahk
; ---------------------------------
; Assigns hotkeys to specific running window instances (such as different VSCode or browser windows)
; for instant switching. Use Win+Alt+N to assign the current active window to slot N (1-9),
; and Win+N to jump to the assigned window. Unassigned slots 1, 2, and 6 default to
; Cursor, Chrome, and GitHub Desktop. Win+1-9 never falls through to Windows taskbar shortcuts.

#Requires AutoHotkey v2

slotCount := 9
global windowIDs := Map()
global defaultApps := Map(
    1, {Name: "Cursor", Exe: "Cursor.exe", Paths: [
        EnvGet("LOCALAPPDATA") "\Programs\cursor\Cursor.exe",
        EnvGet("ProgramFiles") "\Cursor\Cursor.exe"
    ]},
    2, {Name: "Chrome", Exe: "chrome.exe", Paths: [
        EnvGet("ProgramFiles") "\Google\Chrome\Application\chrome.exe",
        EnvGet("ProgramFiles(x86)") "\Google\Chrome\Application\chrome.exe",
        EnvGet("LOCALAPPDATA") "\Google\Chrome\Application\chrome.exe"
    ]},
    6, {Name: "GitHub Desktop", Exe: "GitHubDesktop.exe", Paths: [
        EnvGet("LOCALAPPDATA") "\GitHubDesktop\GitHubDesktop.exe"
    ]}
)

; Keep every Win+number shortcut global, including empty slots. A conditional
; hotkey would let Windows handle the shortcut when its condition is false.
HotIf()
Loop slotCount {
    idx := A_Index
    Hotkey("#!" idx, AssignWindowToSlot.Bind(idx))
    Hotkey("#" idx, ActivateSlotWindow.Bind(idx))
}

AssignWindowToSlot(idx, *) {
    global windowIDs
    winID := WinGetID("A")
    windowIDs[idx] := winID
    ShowStatus("Slot #" idx " assigned to window ID " winID)
}

ActivateSlotWindow(idx, *) {
    global windowIDs, defaultApps
    winID := windowIDs.Has(idx) ? windowIDs[idx] : ""
    if winID && WinExist("ahk_id " winID) {
        WinActivate("ahk_id " winID)
        return
    }

    ; A closed assigned window frees the slot for its default app.
    if winID
        windowIDs.Delete(idx)

    if defaultApps.Has(idx) {
        try ActivateDefaultApp(defaultApps[idx])
        catch Error as err
            ShowStatus("Could not open " defaultApps[idx].Name ": " err.Message)
    } else if winID {
        ShowStatus("Slot #" idx " window no longer exists!")
    } else {
        ShowStatus("Slot #" idx " not assigned yet.")
    }
}

ActivateDefaultApp(app) {
    winID := FindLowestPIDWindow(app.Exe)
    if !winID {
        launchPath := app.Exe
        for path in app.Paths {
            if FileExist(path) {
                launchPath := path
                break
            }
        }

        ; Running again also opens a window when the app is only running in the background.
        Run('"' launchPath '"')
        if !WinWait("ahk_exe " app.Exe, , 15) {
            ShowStatus("Timed out waiting for " app.Name " to open a window.")
            return
        }
        winID := FindLowestPIDWindow(app.Exe)
    }

    if winID
        WinActivate("ahk_id " winID)
}

FindLowestPIDWindow(exe) {
    lowestPID := 0
    selectedWindow := 0
    for winID in WinGetList("ahk_exe " exe) {
        ; Windows can close while the list is being inspected.
        try pid := WinGetPID("ahk_id " winID)
        catch TargetError
            continue

        if !selectedWindow || pid < lowestPID {
            lowestPID := pid
            selectedWindow := winID
        }
    }
    return selectedWindow
}

ShowStatus(message) {
    ToolTip(message)
    SetTimer(RemoveToolTip, -1500)
}

RemoveToolTip(*) {
    ToolTip()
}
