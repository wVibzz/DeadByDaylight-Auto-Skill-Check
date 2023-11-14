#SingleInstance Force
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
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
}

xMidScrn :=  A_ScreenWidth //2
yMidScrn :=  A_ScreenHeight //2
colorwhite := "0xFFFFFF"
colorred := "0xC90001"
hyperfocusperk := False


f::
MainScript:
while GetKeyState("f", "P") { ;while holding h
	coordmode pixel
	setformat floatfast, 0
	PixelSearch, px, py, 910, 510, 925, 520, colorwhite, 1, Fast RGB
	;mousemove, px, py ;debug
	if ErrorLevel
	{
		return
	}
		else
	{
		arc := 7, radius := 67.5, time := a_tickcount ;arc is speed it checks the circle. Radius is the circle area it revolves around
		plot(xMidScrn, yMidScrn - 15, a_index * arc, radius, x2, y2)
		PixelSearch, oX, oY, x2, y2, x2, y2, colorwhite , 6, Fast RGB ;search for the color white within 6 shades at the circled area
		;mousemove x2,y2 ;debug 
		If ErrorLevel = 0
		{
		Gosub RedDetect
		}
	}
}
return


RedDetect:
Loop 
{
PixelSearch, XX, YY, x2, y2, x2, y2, colorred , 40, Fast RGB ;stays where it detected the skill check then waits for red
;mousemove x2,y2 ;debug
if ErrorLevel = 0
{
Send {Space down}
Send {Space up}
Sleep 100
Goto, MainScript
}
}
return



#x::ExitApp  ; Win+X
