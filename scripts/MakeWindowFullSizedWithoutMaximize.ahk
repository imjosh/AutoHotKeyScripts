; AHKv2

^!f:: { ; CTRL-ALT-F
    hwnd := WinGetID("A")

    ; Get the work area of the screen (excluding taskbar)
    workArea := Buffer(16)
    DllCall("SystemParametersInfoW", "UInt", 0x0030, "UInt", 0, "Ptr", workArea, "UInt", 0) ; SPI_GETWORKAREA
    left := NumGet(workArea, 0, "Int")
    top := NumGet(workArea, 4, "Int")
    right := NumGet(workArea, 8, "Int")
    bottom := NumGet(workArea, 12, "Int")

    width := right - left
    height := bottom - top

    WinMove(left, top, width, height, hwnd)
}
