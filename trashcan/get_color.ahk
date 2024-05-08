

^f::
    sleep, 100
    MouseGetPos, xpos, ypos
    PixelGetColor, color, %xpos%, %ypos%, RGB
    Gui, Add, Text, 0xFF0000, %color% The color at the current cursor position is %color%.
    Gui, Show, w500 h500
    Gui, Color, %color%
return