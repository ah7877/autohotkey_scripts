;Jester Wheel

; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv
; Enable warnings to assist with detecting common errors
;#Warn
; Recommended for new scripts due to its superior speed and reliability
SendMode Input
; Ensures a consistent starting directory
SetWorkingDir %A_ScriptDir%

;eternia crystal
e_c := 0x05DDFF
;goblin 
gob := 0x242800
;sword
swo := 0x72C1E2
;potion
pot := 0xB90000
;manatoken
man := 0x060030


^f::exec_wheel_of_fortune(swo, swo, swo)     ; Damage All Enemies	        Ctrl+F
^t::exec_wheel_of_fortune(pot, pot, pot)     ; Heal All Allies              Ctrl+T


/*
all this is a comment to add the combinations, copy a line with the desirred combination below and paste them above, then add a letter after ^ in the beginning of the line
this will make the keybind: ctrl + the chosen key
combinations
^::exec_wheel_of_fortune(gob, gob, gob)     ; Goden Enemies                 Ctrl+
^::exec_wheel_of_fortune(gob, e_c, e_c)     ; Buff Enemies	                Ctrl+
^::exec_wheel_of_fortune(gob, man, man)     ; Downgrade Nearby Tower	    Ctrl+
^::exec_wheel_of_fortune(swo, man, man)     ; Players Unable to Repair	    Ctrl+
^::exec_wheel_of_fortune(gob, gob, e_c)     ; Debuff Enemies	            Ctrl+
^::exec_wheel_of_fortune(e_c, e_c, e_c)     ; Buff Players	                Ctrl+
^::exec_wheel_of_fortune(swo, swo, swo)     ; Damage All Enemies	        Ctrl+
^::exec_wheel_of_fortune(swo, swo, e_c)     ; Kill Portion Of Enemies	    Ctrl+
^::exec_wheel_of_fortune(gob, gob, pot)     ; Stun Enemies	                Ctrl+
^::exec_wheel_of_fortune(pot, pot, man)     ; Slow-Motion	                Ctrl+
^::exec_wheel_of_fortune(man, man, man)     ; Upgrade Nearest Tower		    Ctrl+
^::exec_wheel_of_fortune(pot, pot, pot)     ; Heal All Allies               Ctrl+
*/

slot_match(bx, by, tx, ty, colour){
    CoordMode, Pixel, Client

    /*
    ;this is too see if the area that is checked is in the correct slot
    sleep 1000
    MouseMove, bx, by
    sleep 1000
    MouseMove, tx, ty
    */
    

    iFailState = 100
    While (iFailState) {
        PixelSearch, Px, Py, bx, by, tx, ty, colour, 2, Fast RGB
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
    WinGetPos, X, Y, w, h, Dungeon Defenders
    if (X = "" or Y = "" or w = "" or h = ""){
        MsgBox, The window "Dungeon Defenders" is not currently open.
        return
    }

    ;this seems to be the relation between the distance between slot 1 and 2 and the hight of the program
    res := 0.186 * h - 3
    
    /*
    ;this is to check if ahk can find the right window size
    MsgBox, Width: %w% Height: %h%
    MsgBox, Width: %X% Height: %Y%
    */

    ;y0 is hight x1-3 is the width to hit center of slot 1-3 
    y0 := Round(h / 2)
    x2 := Round(w / 2)
    x1 := Round(x2 - res)
    x3 := Round(x2 + res)

    /*
    ;this is to check if the center of the area is within the desired spot for each slot
    MouseMove, x1, y0
    sleep, 1000
    MouseMove, x2, y0
    sleep, 1000
    MouseMove, x3, y0
    sleep, 1000
    */

    CalculateCorners(tlX1, tlY, brX1, brY, x1, y0, w, h)
    CalculateCorners(tlX2, tlY, brX2, brY, x2, y0, w, h)
    CalculateCorners(tlX3, tlY, brX3, brY, x3, y0, w, h)

    
    Send {3 DownTemp}
    Sleep, 5
    Send {3 up} 
    Sleep, 100

    /*
    ;this is too see if the area that is checked is in the correct slot
    MouseMove, tlX1, tlY
    sleep 1000
    MouseMove, brX1, brY
    MsgBox, %tlX1% & %tlY% & %brX1% & %brY% & %x1% & %y0%
    sleep 1000

    MouseMove, tlX2, tlY
    sleep 1000
    MouseMove, brX2, brY
    MsgBox, %tlX2% & %tlY% & %brX2% & %brY% & %x2% & %y0%
    sleep 1000

    MouseMove, tlX3, tlY
    sleep 1000
    MouseMove, brX3, brY
    MsgBox, %tlX3% & %tlY% & %brX3% & %brY% & %x3% & %y0%
    sleep 1000
    */

    /*
    ;this is to check the color is somewhat what u expect
    color := cSlot1
    Gui, Add, Text, 0xFF0000, %color% The color at the current cursor position is %color%.
    Gui, Show, w500 h500
    Gui, Color, %color%
    */

    if (slot_match(tlX1, tlY, brX1, brY, cSlot1) == 0) {      ; Slot 1
        ;MsgBox, s1 failed
        return
    }
    if (slot_match(tlX2, tlY, brX2, brY, cSlot2) == 0) {      ; slot 2
        ;MsgBox, s2 failed
        return
    }    
    if (slot_match(tlX3, tlY, brX3, brY, cSlot3) == 0) {      ; slot 3
        ;MsgBox, s3 failed
        return
    }

    ;MsgBox, %cSlot1% & %cSlot2% & %cSlot3%
    return
}


CalculateCorners(ByRef top_left_x, ByRef top_left_y, ByRef bottom_right_x, ByRef bottom_right_y, centerX, centerY, window_width, window_hight) {
    width := 100 * window_width / 1920
    hight := 100 * window_hight / 1080

    half_width := Floor(width/2)
    half_hight := Floor(hight/2)
   
    top_left_x := Round(centerX - half_width)
    top_left_y := Round(centerY - half_hight)
   
    bottom_right_x := Round(centerX + half_width)
    bottom_right_y := Round(centerY + half_hight)
}


/*
;this peice of code must be used in a seperate script, but is nessessary to make adjustments
;this is to show the position of the mouse relative to the currently open window and the color of that specific pixel
#Persistent
SetTimer, UpdateCursorPosition, 100
return

UpdateCursorPosition:
MouseGetPos, X, Y
PixelGetColor, color, %X%, %Y%, RGB
ToolTip, X: %X% Y: %Y% color: %color%
return
*/