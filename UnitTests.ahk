#Include %A_ScriptDir%\lib\Classes.ahk

Class_Console("PokerBotLog", 100, 100, 300, 500)
PokerBotLog.show("PokerBotLog")
; Test of betting logic
myGame := new Game(new Array(1,2,3), new Array(new Array("4C", "4D"),new Array("AC", "QH"),	new Array("5S", "JS")),	1) ; End new Game()

if (myGame.ShouldIBet() == true)
{
	PokerBotLog.log("Test 1: Should not have bet!")
	throw new exception("Should not have bet")
}

WinWaitClose,Console DebugID "PokerBotLog"
ExitApp