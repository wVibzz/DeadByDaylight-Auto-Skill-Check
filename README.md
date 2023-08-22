# DBDAutoQTE


Code:
Ahk Version 1.1.x



#SingleInstance Force
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#SingleInstance Force
#KeyHistory 0


ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input

plot(x1, y1, a, r, byref x2, byref y2) {    
rad := (a * 0.01745329252)
x2 := (x1 + sin(rad) * r) ;starts from top of circle
y2 := (y1 - cos(rad) * r) 
;x2 := (x1 + cos(rad) * r) ;starts from right side of circle
;y2 := (y1 + sin(rad) * r)
}

xMidScrn :=  A_ScreenWidth //2
yMidScrn :=  A_ScreenHeight //2
colorwhite := "0xFFFFFF"

repairspeed := 4.8
healspeed := 2.45
currentspeed := repairspeed
hyperfocusperk := False

1::
currentspeed := repairspeed
ToolTip, Repair Mode,900, 840
Sleep 800
ToolTip
return
2::
currentspeed := healspeed
ToolTip, Heal Mode,900, 840
Sleep 800
ToolTip
return

h::
while GetKeyState("h", "P") { ;while holding h
	coordmode mouse
	coordmode pixel
	setformat floatfast, 0
	PixelSearch, px, py, 930, 509, 940, 514, colorwhite, 1, Fast RGB
	;mousemove, px, py ;to check binding box for skill check
	if ErrorLevel
	{
		return
	}
	else
	{
	ToolTip,Found Binding, 900, 840
	arc := currentspeed, radius := 67, time := a_tickcount ;arc is speed it checks the circle radius is the circle area it revolves around
	plot(xMidScrn, yMidScrn - 15, a_index * arc, radius, x2, y2)
	PixelSearch, oX, oY, x2, y2, x2, y2, colorwhite , 20, Fast RGB ;search for the color white within 20 shades at the circled area
	;mousemove x2,y2 ;to check scanning circle
	If ErrorLevel = 0
	{
	ToolTip, Found GSC,  900, 840
	Sleep 200
	Send {Space down}
	Sleep 10
	Send {Space up}
	ToolTip
	}
	Else ErrorLevel = 1
	{
	}
	}
}
return
