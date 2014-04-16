#Include %A_ScriptDir%\lib\Classes.ahk
#Include %A_ScriptDir%\Classes\ScreenMapper.ahk
#Include %A_ScriptDir%\Classes\Card.ahk
#Include %A_ScriptDir%\Classes\Deck.ahk

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
myScreenMapper.SetRect(1000,0,100,50)
if (myScreenMapper.x != 0 && myScreenMapper.y != 0)
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

;TestScreenMapper_Screenshot
filename := A_ScriptDir . "\Assets\" A_Now ".bmp"
myScreenMapper.Screenshot(filename)
;Verify that image exists

myFile := FileOpen(filename, "r")
if (not(IsObject(myFile)))
{
	Console.log("Could not find screenshot")
}
myFile.Close()

;TestScreeMapper_FindImage with our new image
if (myScreenMapper.FindImage(filename) == false)
{
	Console.log("Couldn't find my image")
}

;remove the screenshot -- this test is failing
FileDelete, %filename%
if (ErrorLevel != 0 or A_LastError !=0)
{
	Console.log("Could not delete screenshot. A_LastError: " A_LastError "; ErrorLevel: " ErrorLevel)
}

;Test_Card
myCardBadFileName := new Card("Wheeeee","c:\wheeeeeeeeeee")
if (myCardBadFileName.isValid == true)
{
	Console.log("Card was valid with bad filename")
}

if (myCardBadFileName.FileFullPath != "c:\wheeeeeeeeeee")
{
	Console.log("FileFullPath" myCardBadFileName.FileFullPath)
}

myCardBadRank := new Card("IH.jpg", "c:\wheeee")
if (myCardBadRank.isValid == true)
{
	Console.log("Card was valid with a bad rank")
}

myCardBadSuit := new Card("AI.jpg", "c:\wheeee")
if (myCardBadSuit.isValid == true)
{
	Console.log("Card was valid with bad suit.")
}

myCardValidCard := new Card("AH.jpg", "c:\wheeee")
if (myCardValidCard.isValid == false)
{
	Console.log("Card was valid, but returned as invalid" myCardValidCard.inValidReason)
}

;Test_Deck 
myDeck := new Deck(A_ScriptDir "\Assets\site1\deck", Console)

if (myDeck.myCards.MaxIndex() != 1)
{
	Console.log("Expecting only 1 valid card in the test deck. Found " myDeck.myCards.MaxIndex())
}

if (myDeck.myUnknownCards.MaxIndex() != 1)
{
	Console.log("Expecting only 1 unknown card in the deck.  Found " myDeck.myUnknownCards.MaxIndex())
}

; Let's try to find a "Card".  This will be the upper left hand corner of the screen.  This should fail, but create a screenshot.
myFirstCard := myDeck.FindCard(0,0,10,10)
if (myFirstCard.isValid==true)
{
	Console.log("Found a card and we shouldn't")
}

; verify that the screenshot was taken, and stored in the unknown cards deck
if (myDeck.myUnknownCards.MaxIndex() != 2)
{
	Console.log("Expected 2 unknown cards in the deck.  Found " myDeck.myUnknownCards.MaxIndex())
}

; verify that the file was written
myFile := FileOpen(myFirstCard.FileFullPath,"r")
if (not(IsObject(myFile)))
{
	Console.log("Could not find screenshot.  FileFullPath: " myFirstCard.FileFullPath)
}
myFile.Close()

; Find the card we just searched for again.  
mySecondCard := myDeck.FindCard(0,0,10,10)

;the number of unknown cards should stay the same.
if (myDeck.myUnknownCards.MaxIndex() != 2)
{
	Console.log("Expected 2 unknown cards in the deck.  Found " myDeck.myUnknownCards.MaxIndex())
}

; I believe the image fine is not working.

;the first and second card should be the same
if (myFirstCard.FileFullPath != mySecondCard.FileFullPath)
{
	Console.log("A second screenshot was taken, and shouldn't have been; myFirstCard.FileFullPath: " myFirstCard.FileFullPath "; mySecondCard.FileFullPath" mySecondCard.FileFullPath)
}

Console.log("All done")
WinWaitClose,Console DebugID "Console"
ExitApp