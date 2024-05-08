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


global active_player := 1
global are_all_the_active_players_visible := true
global is_this_player_active := [1, 0, 0, 0]


^f::switch_case(swo, swo, swo)     ; Damage All Enemies	        Ctrl+F
^t::switch_case(pot, pot, pot)     ; Heal All Allies            Ctrl+T


/*
all this is a comment to add the combinations, copy a line with the desirred combination below and paste them above, then add a letter after ^ in the beginning of the line
this will make the keybind: ctrl + the chosen key
combinations
^::switch_case(gob, gob, gob)     ; Goden Enemies
^::switch_case(gob, e_c, e_c)     ; Buff Enemies
^::switch_case(gob, man, man)     ; Downgrade Nearby Tower
^::switch_case(swo, man, man)     ; Players Unable to Repair
^::switch_case(gob, gob, e_c)     ; Debuff Enemies
^::switch_case(e_c, e_c, e_c)     ; Buff Players
^::switch_case(swo, swo, swo)     ; Damage All Enemies
^::switch_case(swo, swo, e_c)     ; Kill Portion Of Enemies
^::switch_case(gob, gob, pot)     ; Stun Enemies
^::switch_case(pot, pot, man)     ; Slow-Motion
^::switch_case(man, man, man)     ; Upgrade Nearest Tower
^::switch_case(pot, pot, pot)     ; Heal All Allies
*/



~F2:: 
    if (WinActive("Dungeon Defenders")) {
        active_player := 1
    }
return

~F3::
    f2_to_f5(2)
return

~F4::
    f2_to_f5(3)
return

~F5::
    f2_to_f5(4)
return


~F6::
    if (WinActive("Dungeon Defenders")) {
        active_player := 1

        loop, 3 {
            if(is_this_player_active[A_Index + 1] == 0){
                is_this_player_active[A_Index + 1] := player_count() + 1
            }
        }
    }
return

~F7::
    if (WinActive("Dungeon Defenders")) {
        are_all_the_active_players_visible := true
        active_player := 1

        loop, 3
            is_this_player_active[A_Index + 1] := 0
    }
return


~F8:: 
    if (WinActive("Dungeon Defenders")) {
        if(player_count() != 1)
            are_all_the_active_players_visible := !are_all_the_active_players_visible
    }
return

f2_to_f5(num){
    if (WinActive("Dungeon Defenders")) {
        if(is_this_player_active[num] == 0){
            is_this_player_active[num] := player_count() + 1
            are_all_the_active_players_visible := true
        }
        active_player := num
    }
}


player_count(){
    player_count := 0
    for index, value in is_this_player_active {
        if(value != 0)
            player_count += 1
    }
    return player_count
}


switch_case(cSlot1, cSlot2, cSlot3) {

    if (!are_all_the_active_players_visible and active_player != 1)
        return

    WinGetPos, X, Y, w, h, Dungeon Defenders
    if (X = "" or Y = "" or w = "" or h = ""){
        MsgBox, The window "Dungeon Defenders" is not currently open.
        return
    }

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
                switch is_this_player_active[active_player] {
                    case 1:
                        left_side(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        right_side(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    default:
                        MsgBox, % "wrong active player: " active_player
                        ExitApp
                        return
                }
                return
            case 3:
                switch is_this_player_active[active_player] {
                    case 1:
                        left_side(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        top_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 3:
                        bottom_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    default:
                        MsgBox, % "playercount: " . player_count() . "wrong active player: " . active_player
                        ExitApp
                        return
                }
                return
            case 4:
                switch is_this_player_active[active_player] {
                    case 1:
                        top_left_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 2:
                        top_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 3: 
                        bottom_left_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
                        return
                    case 4:
                        bottom_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
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
    return 
}



left_side(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    width_of_player_window := width_of_player_window / 2
    w := w / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



right_side(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    width_of_player_window := width_of_player_window / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



top_left_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    hight_of_player_window := hight_of_player_window / 2
    width_of_player_window := width_of_player_window / 2
    h := h / 2
    w := w / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



top_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    hight_of_player_window := hight_of_player_window / 2
    width_of_player_window := width_of_player_window / 2
    h := h / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



bottom_left_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    hight_of_player_window := hight_of_player_window / 2
    width_of_player_window := width_of_player_window / 2
    w := w / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



bottom_right_corner(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window){

    hight_of_player_window := hight_of_player_window / 2
    width_of_player_window := width_of_player_window / 2

    exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window)
}



exec_wheel_of_fortune(cSlot1, cSlot2, cSlot3, h, hight_of_player_window, w, width_of_player_window) {
    ;this seems to be the relation between the distance between slot 1 and 2 and the hight of the program
    res := 0.186 * hight_of_player_window - 3


    ;y0 is hight x1-3 is the width to hit center of slot 1-3 
    y0 := Round(h - hight_of_player_window / 2)
    x2 := Round(w - width_of_player_window / 2)
    x1 := Round(x2 - res)
    x3 := Round(x2 + res)
    

    CalculateCorners(tlX1, tlY, brX1, brY, x1, y0, width_of_player_window, hight_of_player_window)
    CalculateCorners(tlX2, tlY, brX2, brY, x2, y0, width_of_player_window, hight_of_player_window)
    CalculateCorners(tlX3, tlY, brX3, brY, x3, y0, width_of_player_window, hight_of_player_window)

    
    Send {3 DownTemp}
    Sleep, 5
    Send {3 up} 
    Sleep, 100


    if (slot_match(tlX1, tlY, brX1, brY, cSlot1) == 0) {      ; Slot 1
        return
    }
    if (slot_match(tlX2, tlY, brX2, brY, cSlot2) == 0) {      ; slot 2
        return
    }    
    if (slot_match(tlX3, tlY, brX3, brY, cSlot3) == 0) {      ; slot 3
        return
    }

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


slot_match(bx, by, tx, ty, colour){
    CoordMode, Pixel, Client

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