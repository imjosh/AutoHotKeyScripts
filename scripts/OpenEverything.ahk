; OpenEverything.ahk
; Remaps Win+F to open Everything search (blocks Windows Search/Copilot).

#Requires AutoHotkey v2

#f:: {
    static everythingExe := "C:\Program Files\Everything\Everything.exe"
    static winTitle := "ahk_class EVERYTHING"

    Run('"' everythingExe '" -search ""')
    if !WinWait(winTitle, , 3)
        return

    hwnd := WinExist(winTitle)
    WinActivate(winTitle)
    if !WinWaitActive(winTitle, , 0.4)
        ForceForeground(hwnd)

    ControlFocus("Edit1", winTitle)
}

ForceForeground(hwnd) {
    if !hwnd
        return

    ; Windows blocks SetForegroundWindow unless this thread is attached
    ; to the current foreground input queue.
    fgHwnd := DllCall("GetForegroundWindow", "Ptr")
    thisTID := DllCall("GetCurrentThreadId", "UInt")
    fgTID := DllCall("GetWindowThreadProcessId", "Ptr", fgHwnd, "Ptr", 0, "UInt")
    if fgTID && thisTID != fgTID
        DllCall("AttachThreadInput", "UInt", thisTID, "UInt", fgTID, "Int", true)

    DllCall("BringWindowToTop", "Ptr", hwnd)
    DllCall("SetForegroundWindow", "Ptr", hwnd)

    if fgTID && thisTID != fgTID
        DllCall("AttachThreadInput", "UInt", thisTID, "UInt", fgTID, "Int", false)

    if !WinActive("ahk_id " hwnd)
        DllCall("SwitchToThisWindow", "Ptr", hwnd, "Int", 1)
}
