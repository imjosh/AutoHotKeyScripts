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

; launchapp2 to open ChatGPT using the ChatGPT 5.2-Auto Model
Launch_App2::
{
    Run("chrome.exe --new-tab https://chatgpt.com/g/g-6941788c3b5c8191b87b4a6e6e9f532c-5-2-auto")
}

; Ctrl+Launch_App2 to open ChatGPT using the 5.2-Thinking Model
^Launch_App2::
{
  Run("chrome.exe --new-tab https://chatgpt.com/g/g-6941777f48ac819190d9eeee294b43a9-thinking")
}

; NumpadIns (#0) to hold down ctrl+shift
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

; Make Ctrl+W close the current tab in SSMS (type ctrl+f4)
#HotIf WinActive("SQL Server Management Studio")
^w::{
  Send("^{F4}")
}
#HotIf

; numpad enter = undo (ctrl-z)
NumpadEnter::Send("^z")

NumpadLeft::Send("^+{Left}")
NumpadRight::Send("^+{Right}")
NumpadUp::Send("+{Up}")
NumpadDown::Send("+{Down}")

;NumpadDel::Send("NumpadDel")
