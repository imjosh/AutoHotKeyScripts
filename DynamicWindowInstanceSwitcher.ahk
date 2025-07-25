; DynamicWindowInstanceSwitcher.ahk
; ---------------------------------
; Assigns hotkeys to specific running window instances (such as different VSCode or browser windows)
; for instant switching. Use Win+Alt+N to assign the current active window to slot N (1-5),
; and Win+N to jump to the assigned window. Easily reassign hotkeys as windows open and close.

#Requires AutoHotkey v2

slotCount := 9
global windowIDs := Map()

; Map Win+[1-9] to jump to a window, set by Win+Alt+[1-9]
Loop slotCount {
    idx := A_Index
    Hotkey("#!" idx, AssignWindowToSlot.Bind(idx))
    Hotkey("#" idx, ActivateSlotWindow.Bind(idx))
}

AssignWindowToSlot(idx, *) {
    global windowIDs
    winID := WinGetID("A")
    windowIDs[idx] := winID
    ToolTip("Slot #" idx " assigned to window ID " winID)
    SetTimer(RemoveToolTip, -1500)
}

ActivateSlotWindow(idx, *) {
    global windowIDs
    winID := windowIDs.Has(idx) ? windowIDs[idx] : ""
    if winID && WinExist("ahk_id " winID) {
        WinActivate("ahk_id " winID)
    } else if winID {
        ToolTip("Slot #" idx " window no longer exists!")
        SetTimer(RemoveToolTip, -1500)
    } else {
        ToolTip("Slot #" idx " not assigned yet.")
        SetTimer(RemoveToolTip, -1500)
    }
}

RemoveToolTip(*) {
    ToolTip()
}
