#Include %A_ScriptDir%\lib\Classes.ahk
#Include %A_ScriptDir%\Classes\ScreenMapper.ahk

;Initialize Logging
Class_Console("Console", 100, 100, 300, 500)
Console.show("Console")
/*
;Test_ShouldIBet
myGame := new Game(new Array(1,2,3), new Array(new Array("4C", "4D"),new Array("AC", "QH"),	new Array("5S", "JS")),	1) ; End new Game()
if (myGame.ShouldIBet() == true)
{
	Console.log("Test 1: Should not have bet!")
	;throw new exception("Should not have bet")
}

*/
;Test_ScreenMaper
myScreenMapper := new ScreenMapper()
if (myScreenMapper.isInitialized() == false)
{
		Console.log("Not initialized")
}

;Test_ScreenMapper_SetRect
myScreenMapper.SetRect(10,10,500,500)
if (myScreenMapper.x != 10 && myScreenMapper.y != 10)
{
	Console.log("coordinates wrong")
}
;Test_ScreenMapper_FindImage with invalidImage
try
{
	myScreenMapper.FindImage("test.png")
} 
catch 
{ }

;TestScreenMapper_FindImage with a bad image
if (myScreenMapper.FindImage(A_ScriptDir . "\Assets\photo.jpg") == true)
{
	Console.log("Found Image and shouldn't")
}

testArray := new Array(A_ScriptDir . "\Assets\photo.jpg")
myScreenMapper.FindImages(testArray)

WinWaitClose,Console DebugID "Console"
ExitApp