; AHKv2

; fixme todo - instead of using NumpadIns (0) to just be ctrl+shift, can I use it like a "hyperkey":
;  NumpadIns+p = ctrl+shift+p
;  NumpadIns+up = ctrl+alt+up ; multi-cursor select
;  NumpadIns+down = ctrl+alt+down ; multi-cursor select
;  NumpadIns+Launch_App2 = open Gemini AI
;
; Can I map a mouse key to the 0+numpad key? regardless, I can ahk the button to the same set of shortcuts
; See if the CE and +/- keys can actually be distinguished from delete and f9 -> most probably not according to reddit
; but, could do NumpadIns+f9 = whatever I want, and NumpadIns+delete = whatever I want

; Remap numpad_multiply to send Ctrl+C
NumpadMult::Send("^c")

; Remap numpad_divide to send Ctrl+V
NumpadDiv::Send("^v")

; Remap numpad_subtract to send Ctrl+X
NumpadSub::Send("^x")

; Remap numpad_add to send Ctrl+A
NumpadAdd::Send("^a")

; Remap launchapp2 to open https://chatgpt.com in a new Chrome tab
Launch_App2::
{
    Run("chrome.exe --new-tab https://chatgpt.com")
}

NumpadIns::
{
    Send("{Ctrl Down}{Shift Down}")
    KeyWait("Insert") ; Wait for Insert to be released
    Send("{Ctrl Up}{Shift Up}")
}


; Remap numpad clear (the #5 key) to delete line in cursor and vscode
#HotIf WinActive("ahk_exe Code.exe")
NumpadClear::Send("^+k") ; VS Code: delete line
#HotIf

#HotIf WinActive("ahk_exe cursor.exe")
NumpadClear::Send("^+!d") ; Cursor: delete line with Ctrl+Shift+Alt+D
#HotIf


; numpad enter = undo (ctrl-z)
NumpadEnter::Send("^z")

NumpadLeft::Send("^+{Left}")
NumpadRight::Send("^+{Right}")
NumpadUp::Send("+{Up}")
NumpadDown::Send("+{Down}")

;NumpadDel::Send("NumpadDel")


