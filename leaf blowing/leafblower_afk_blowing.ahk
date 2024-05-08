#Requires AutoHotkey v2.0

^g:: afk_blowing()

esc:: ExitApp

afk_blowing(){
    while(true){
        MouseMove 360, 260 
        sleep 500
        MouseMove 360, 760 
        sleep 500
        MouseMove 930, 760
        sleep 500
        MouseMove 1500, 760 
        sleep 500
        MouseMove 1500, 260
        sleep 500
        MouseMove 930, 260
        sleep 500
    }
}