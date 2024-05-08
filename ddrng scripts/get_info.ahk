#Persistent
SetTimer, UpdateCursorPosition, 100
return

UpdateCursorPosition:
MouseGetPos, X, Y
PixelGetColor, color, %X%, %Y%, RGB
ToolTip, X: %X% Y: %Y% color: %color%
return