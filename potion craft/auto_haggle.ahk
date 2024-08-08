
#NoEnv


;pointer color
pointer_color := 0x391E13 ; edge
;BB7234 filler
;9C5521 pattern

;field to click color
edge_of_target := 0xC49142
; CFA150 background color

x_left := 0.30 * screen_width ; 580 fullscreen
x_right := 0.70 * screen_width ; 1340 fullscreen 
y := 0,416 * screen_hight ; 450 fullscreen


^h:: haggle()


areasize := 10
bx_exit := 650 - areasize/2
by_exit := 490 - areasize/2
tx_exit := 650 + areasize/2
ty_exit := 490 + areasize/2
exit_color := 0xD58458

haggle(){
    MsgBox, hi
    WinGetPos, X, Y, w, h, Potion Craft
    if (X = "" or Y = "" or w = "" or h = ""){
        MsgBox, The window "Potion Craft" is not currently open.
        return
    }
    
    while haggle_stopped(){
        break
    }
}


haggle_stopped(){
    CoordMode, Pixel, Client
    PixelSearch, Px, Py, bx_exit, by_exit, tx_exit, ty_exit, exit_color, 5, Fast RGB
    If (ErrorLevel != 0) {
        MsgBox, false
        return false
    }
    MsgBox, true
    return true
}


get_x_of_targets(){

}