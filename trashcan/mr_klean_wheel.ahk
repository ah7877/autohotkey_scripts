;Jester Wheel
sword := 0x00020F

^d::exec_wheel_of_fortune(sword, sword, sword)     ; % Damage          Ctrl+D
/*^f::exec_wheel_of_fortune(0xFEF906, 0xCCAF5F, 0xCCAF5F)     ; Kill %            Ctrl+F
^s::exec_wheel_of_fortune(0x000064, 0x000064, 0x000064)     ; Heal Allies       Ctrl+S
^t::exec_wheel_of_fortune(0x002623, 0x002623, 0x002623)     ; Gold Enemies      Ctrl+T
^a::exec_wheel_of_fortune(0xFEE206, 0xFEE206, 0xFEE206)     ; Buff Players      Ctrl+A
^z::exec_wheel_of_fortune(0xFEE206, 0x002623, 0x002623)     ; Debuff Enemies    Ctrl+Z
*/

/*
^d::exec_wheel_of_fortune(0xCCAE5F, 0xCCAE5F, 0xCCAE5F)     ; % Damage          Ctrl+D
^f::exec_wheel_of_fortune(0xFEF906, 0xCCAF5F, 0xCCAF5F)     ; Kill %            Ctrl+F
^s::exec_wheel_of_fortune(0x000064, 0x000064, 0x000064)     ; Heal Allies       Ctrl+S
^t::exec_wheel_of_fortune(0x002623, 0x002623, 0x002623)     ; Gold Enemies      Ctrl+T
^a::exec_wheel_of_fortune(0xFEE206, 0xFEE206, 0xFEE206)     ; Buff Players      Ctrl+A
^z::exec_wheel_of_fortune(0xFEE206, 0x002623, 0x002623)     ; Debuff Enemies    Ctrl+Z
*/
slot_match(bx, by, tx, ty, colour){
    CoordMode, Pixel, Client
    iFailState = 80
    While (iFailState) {
        PixelSearch, Px, Py, bx, by, tx, ty, colour, 2, Fast
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
    GetClientSize(WinExist("Dungeon Defenders"), wcW, wcH)
    S1x1 := Round(wcW*0.41927)
    S1x2 := Round(wcW*0.42448)
    S1y1 := Round(wcH*0.46296)
    S1y2 := Round(wcH*0.53240)

    S2x1 := Round(wcW*0.48958)
    S2x2 := Round(wcW*0.49740)
    S2y1 := Round(wcH*0.46296)
    S2y2 := Round(wcH*0.53240)

    S3x1 := Round(wcW*0.57031)
    S3x2 := Round(wcW*0.57552)
    S3y1 := Round(wcH*0.46296)
    S3y2 := Round(wcH*0.53240)
    ;/*
    MouseMove, S1x1, S1y1
    sleep, 5000
    MouseMove, S1x2, S1y2
    ;*/
    /*

    Send {3 DownTemp}
    Sleep, 5
    Send {3 up} 
    Sleep, 100

    if (slot_match(S1x1, S1y1, S1x2, S1y2, cSlot1) == 0) {    ; Slot 1
        return
    }
    if (slot_match(S2x1, S2y1, S2x2, S2y2, cSlot2) == 0) {      ; slot2
        return
    }
    slot_match(S3x1, S3y1, S3x2, S3y2, cSlot3)                ; slot3
    ;MsgBox, %wcW%x%wcH%  %S1x1%x%S1y1% & %S1x2%x%S1y2%
    */
}

;Get's current Dungeon Defender's client size
GetClientSize(hWnd, ByRef w := "", ByRef h := "")
{
    VarSetCapacity(rect, 16)
    DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
    w := NumGet(rect, 8, "int")
    h := NumGet(rect, 12, "int")
}