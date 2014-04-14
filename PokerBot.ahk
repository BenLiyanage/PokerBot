#SingleInstance Force
#Include %A_ScriptDir%\lib\Class_Console.ahk

SetWorkingDir %A_ScriptDir%
CoordMode, ToolTip, Screen
CoordMode, Mouse, Window
SendMode Input
SetKeyDelay, 0, 0

Class_Console("PokerBotLog", 100, 100, 300, 500)
PokerBotLog.show("PokerBotLog")
PokerBotLog.log("Test")
Sleep, 3000
PokerBotLog.log("Test 2")
Sleep, 2000
WinWaitClose,Console DebugID "PokerBotLog"
ExitApp