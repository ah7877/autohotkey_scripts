#Persistent
SetTimer, UpdateCursorPosition, 100
return

;y offset from curser to box is 15
;x offset from curser to box is 15
UpdateCursorPosition:
MouseGetPos, X, Y
PixelGetColor, color, %X%, %Y%, RGB
ToolTip, X: %X% Y: %Y% color: %color%
return