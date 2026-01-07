; AHKv2

; fixme todo - instead of using NumpadIns (0) to just be Ctrl+Shift, can I use it like a "hyperkey", e.g.:
;  NumpadIns+p = Ctrl+Shift+Up
;  NumpadIns+Up = Ctrl+Alt+Up ; multi-cursor select
;  NumpadIns+Down = Ctrl+Alt+Down ; multi-cursor select
;  NumpadIns+Launch_App2 = open Gemini AI
;
; Can I map a mouse key to the 0+numpad key? regardless, I can ahk the button to the same set of shortcuts
; See if the CE and +/- keys can actually be distinguished from delete and F9 -> most probably not according to reddit
; but, could do NumpadIns+F9 = whatever I want, and NumpadIns+delete = whatever I want

; Remap numpad_multiply to send Ctrl+C
NumpadMult::Send("^c")

; Remap numpad_divide to send Ctrl+V
NumpadDiv::Send("^v")

; Remap numpad_subtract to send Ctrl+X
NumpadSub::Send("^x")

; Remap numpad_add to send Ctrl+A
NumpadAdd::Send("^a")

; launchapp2 to open ChatGPT
Launch_App2::
{
    Run("chrome.exe --new-tab https://chatgpt.com")
}

; ; Ctrl+Launch_App2 to open ChatGPT using the 5.2-Thinking Model (via private, custom GPT)
; ; NOTE: disabled because custom GPT sessions cannot be added to projects
; ^Launch_App2::
; {
;   Run("chrome.exe --new-tab https://chatgpt.com/g/g-6941777f48ac819190d9eeee294b43a9-thinking")
; }

; NumpadIns (#0) to hold down Ctrl+Shift
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

; Make Ctrl+W close the current tab in SSMS (type Ctrl+F4)
#HotIf WinActive("SQL Server Management Studio")
^w::{
  Send("^{F4}")
}
#HotIf

; numpad enter = undo (Ctrl-z)
NumpadEnter::Send("^z")

; numpad arrows = Ctrl+Shift+arrow keys
NumpadLeft::Send("^+{Left}")
NumpadRight::Send("^+{Right}")
NumpadUp::Send("+{Up}")
NumpadDown::Send("+{Down}")
