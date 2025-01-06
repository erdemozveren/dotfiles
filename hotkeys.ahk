#Requires AutoHotkey v2.0

CapsLock := false
SetCapsLockState "AlwaysOff"

; media controls
#]:: Send "{Volume_Up}"
#[::  Send "{Volume_Down}"
#m::  Send "{Volume_Mute}"

#HotIf (GetKeyState("CapsLock", "P"))
{
    ; hjkl navigation
    h::Send "{Left}"
    j::Send "{Down}"
    k::Send "{Up}"
    l::Send "{Right}"
    
    ; wasd navigation
    w::Send "{Up}"
    a::Send "{Left}"
    s::Send "{Down}"
    d::Send "{Right}"

    ; CapsLock + I to paste (Shift+Insert)
    i::Send "{Shift down}{Insert}{Shift up}"
    ;Bind ; to maximize the current window (` escpaes character)
    `;::Send "{LWin down}{Up}{LWin up}"
    ; Bind to minimize the current window
    '::Send "{LWin down}{Down}{LWin up}"
   ; add ~ 
   \::Send "~"
   ; Toggle CapsLock State
   t::SetCapsLockState GetKeyState('CapsLock', 'T') ? 'AlwaysOff' : 'AlwaysOn'

}
#HotIf


