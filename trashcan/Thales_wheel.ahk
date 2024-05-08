; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv
; Enable warnings to assist with detecting common errors
;#Warn
; Recommended for new scripts due to its superior speed and reliability
SendMode Input
; Ensures a consistent starting directory
SetWorkingDir %A_ScriptDir%

; % Damage
^d::exec_wheel_of_fortune(0xCCAE5F, 0xCCAE5F, 0xCCAE5F)

; Kill %
^g::exec_wheel_of_fortune(0xFEE206, 0xCCAF5F, 0xCCAF5F)

; Heal Allies
^h::exec_wheel_of_fortune(0x000064, 0x000064, 0x000064)

; Gold Enemies
^b::exec_wheel_of_fortune(0x002623, 0x002623, 0x002623)

; Buff Players
^n::exec_wheel_of_fortune(0xFEE206, 0xFEE206, 0xFEE206)

; Debuff Enemies
^m::exec_wheel_of_fortune(0xFEE206, 0x002623, 0x002623)


^r::Reload
Return

; Alt+Escape to exit AHK
^Esc::ExitApp
Return

slot_match(bx, by, tx, ty, colour){
    CoordMode, Pixel, Client
    iFailState = 80
    While (iFailState) {
        PixelSearch, Px, Py, bx, by, tx, ty, colour, 3, Fast
        If (ErrorLevel == 0) {
            Send {Space DownTemp}
            Sleep, 10
            Send {Space up} 
            break
        }
        iFailState -= 1
    }
    return iFailState
}

; execute wheel of fortune
exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3) {
    Send {3 DownTemp}
    Sleep, 10
    Send {3 up} 
    Sleep, 300
    
    ; slot1
    if (slot_match(745, 500, 775, 550, cSlot1) == 0) {
        return
    }
    
    ; slot2
    if (slot_match(885, 500, 910, 550, cSlot2) == 0) {
        return
    }
    
    ; slot3
    slot_match(1025, 500, 1050, 550, cSlot3)
}