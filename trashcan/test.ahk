

^d::
    GetClientSize(WinExist("Dungeon Defenders"), wcW, wcH)
return


GetClientSize(hWnd, ByRef w := "", ByRef h := "")
{
    VarSetCapacity(rect, 16)
    DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
    w := NumGet(rect, 8, "int")
    h := NumGet(rect, 12, "int")
    Gui, Add, Text, , width: %w% hight: %h%
    Gui, Show, w200 h100
}