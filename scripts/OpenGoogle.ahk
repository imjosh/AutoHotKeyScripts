; OpenGoogle.ahk
; Ctrl+G in Chrome opens a new tab straight to Google.
; Passes a URL so new-tab override extensions never run (Ctrl+T would).

#Requires AutoHotkey v2

#HotIf WinActive("ahk_exe chrome.exe")
^g:: {
    Run('chrome.exe --new-tab "https://www.google.com/"')
}
#HotIf
