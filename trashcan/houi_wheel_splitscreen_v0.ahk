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



^f::switch_case(swo, swo, swo)     ; Damage All Enemies	        Ctrl+F
^t::switch_case(pot, pot, pot)     ; Heal All Allies            Ctrl+T
^y::switch_case(pot, pot, man)     ; Slow-Motion	            Ctrl+Y


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



global active_player := 1
global are_all_the_active_players_visible := true
global is_this_player_active := [true, false, false, false]


~F2:: 
    if (WinActive("Dungeon Defenders")) {
        active_player := 1
    }
return

~F3::
    if (WinActive("Dungeon Defenders")) {
        if(!is_this_player_active[2]){
            is_this_player_active[2] := true
            are_all_the_active_players_visible := true
        }
        active_player := 2
    }
return

~F4::
    if (WinActive("Dungeon Defenders")) {
        if(!is_this_player_active[3]){
            is_this_player_active[3] := true
            are_all_the_active_players_visible := true
        }
        active_player := 3
    }
return

~F5::
    if (WinActive("Dungeon Defenders")) {
        if(!is_this_player_active[4]){
            is_this_player_active[4] := true
            are_all_the_active_players_visible := true
        }
        active_player := 4
    }
return


~F6::
    if (WinActive("Dungeon Defenders")) {
        active_player := 1

        loop, 3
            is_this_player_active[A_Index + 1] := true
    }
return

~F7::
    if (WinActive("Dungeon Defenders")) {
        are_all_the_active_players_visible := true
        active_player := 1

        loop, 3
            is_this_player_active[A_Index + 1] := false
    }
return


~F8:: 
    if (WinActive("Dungeon Defenders")) {
        if(player_count() != 1)
            are_all_the_active_players_visible := !are_all_the_active_players_visible
    }
return


player_count(){
    player_count := 0
    for index, value in is_this_player_active {
        if(value)
            player_count += 1
    }
    return player_count
}

active_player_window(){
    active_player_window := 0
    for index, value in is_this_player_active {
        if(value)
            active_player_window += 1
        if(index == active_player)
            break
    }
    return active_player_window
}

/*
;this is for checking if i track whats on the screen correctly in terms of active_player, are_all_the_active_players_visible and is_this_player_active.
^g::
    player_count := player_count()
    active_player_window := active_player_window() 
    ToolTipText := "active_player: " . active_player . "`nare_all_the_active_players_visible: " . (are_all_the_active_players_visible ? "True" : "False") . "`nplayer_count: " . player_count . "`nactive_player_window: " . active_player_window . "`nArray Contents:`n"
    for index, value in is_this_player_active {
        ToolTipText .= "Index " . index . ": " . (value ? "True" : "False") . "`n"
    }
    ToolTip, %ToolTipText%
return
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
switch_case(cSlot1, cSlot2, cSlot3) {
    WinGetPos, X, Y, w, h, Dungeon Defenders
    if (X = "" or Y = "" or w = "" or h = ""){
        MsgBox, The window "Dungeon Defenders" is not currently open.
        return
    }

    /*
    ;this is to check if ahk can find the right window size
    MsgBox, Width: %w% Height: %h%
    MsgBox, Width: %X% Height: %Y%
    */

    if (!are_all_the_active_players_visible and active_player != 1)
        return

    hight_of_player_window = %h%
    width_of_player_window = %w%
    if(!are_all_the_active_players_visible){
        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
    }
    else{
        switch player_count() {
            case 1:
                exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                return
            case 2:
                switch active_player_window() {
                    case 1:
                        half(width_of_player_window)
                        half(w)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        half(width_of_player_window)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    default:
                        MsgBox, % "wrong active player: " active_player
                        ExitApp
                        return
                }
                return
            case 3:
                switch active_player_window() {
                    case 1:
                        half(width_of_player_window)
                        half(w)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        quarter_size(hight_of_player_window, width_of_player_window)
                        half(h)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 3:
                        quarter_size(hight_of_player_window, width_of_player_window)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    default:
                        MsgBox, % "playercount: " . player_count() . "wrong active player: " active_player
                        ExitApp
                        return
                }
                return
            case 4:
                switch active_player_window() {
                    case 1:
                        quarter_size(hight_of_player_window, width_of_player_window)
                        quarter_size(h, w)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        quarter_size(hight_of_player_window, width_of_player_window)
                        half(h)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 3: 
                        quarter_size(hight_of_player_window, width_of_player_window)
                        half(w)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                    return
                    case 4:
                        quarter_size(hight_of_player_window, width_of_player_window)
                        exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    default:
                        MsgBox, % "playercount: " . player_count() . "wrong active player: " active_player
                        Sleep, 5000
                        ExitApp
                        return
                }
                return
            default:
                MsgBox, "playercount is out of bound"
                Sleep, 5000
                ExitApp
                return
        }
    }
}

exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window) {
    ;this seems to be the relation between the distance between slot 1 and 2 and the hight of the program
    res := 0.186 * hight_of_player_window - 3
    
    /*
    ;this is to check if ahk can find the right window size
    MsgBox, Width: %w% Height: %h%
    */

    ;y0 is hight x1-3 is the width to hit center of slot 1-3 
    y0 := Round(h - hight_of_player_window / 2)
    x2 := Round(w - width_of_player_window / 2)
    x1 := Round(x2 - res)
    x3 := Round(x2 + res)

    /*
    msg_text := "Height: " . h . "`nWidth: " . w . "`nhight_of_player_window: " . hight_of_player_window . "`nwidth_of_player_window: " . width_of_player_window . "`n" . y0 . "`n" . x1  . "`n" . x2  . "`n" . x3 
    MsgBox, %msg_text%
    */

    /*
    ;this is to check if the center of the area is within the desired spot for each slot
    MouseMove, x1, y0
    sleep, 1000
    MouseMove, x2, y0
    sleep, 1000
    MouseMove, x3, y0
    sleep, 1000
    */
    

    CalculateCorners(tlX1, tlY, brX1, brY, x1, y0)
    CalculateCorners(tlX2, tlY, brX2, brY, x2, y0)
    CalculateCorners(tlX3, tlY, brX3, brY, x3, y0)

    
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


CalculateCorners(ByRef top_left_x, ByRef top_left_y, ByRef bottom_right_x, ByRef bottom_right_y, centerX, centerY) {
    width := 20
    hight := 60
    half_width := Floor(width/2)
    half_hight := Floor(hight/2)
   
    top_left_x := Round(centerX - half_width)
    top_left_y := Round(centerY - half_hight)
   
    bottom_right_x := Round(centerX + half_width)
    bottom_right_y := Round(centerY + half_hight)
}


half(ByRef var){
    var := round(var/2)
}

quarter_size(ByRef hight, ByRef width){
    half(hight)
    half(width)
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