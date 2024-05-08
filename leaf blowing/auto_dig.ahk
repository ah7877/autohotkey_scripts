
;^g:: afk_dig()
^f:: afk_move()

esc:: ExitApp

afk_dig(){
    while(true){
        Click Down, Left
        Sleep 10
        Click up, Left
        sleep 6500
    }
}


afk_move(){
    while(true){
        loop, 12{
            i := A_Index * 150
            loop, 10{
                j := A_Index * 100
                MouseMove i, j
                sleep 10
            }
            Click Down, Left
            Sleep 10
            Click up, Left
        }
    }
}