

Class Deck 
{
	myCards := Object()
	myUnknownCards := Object()
	
	myPathToDeck := ""
	
	myLogger := ""
	
	__New(PathToDeck, Logger)
	{
		this.myPathToDeck := PathToDeck
		this.myLogger := Logger
		
		; Register All Known Cards
		this.myCards := this.RegisterCards(this.myPathToDeck, false)
		
		; Register unknown cards. These will be used when scraping cards so we don't duplicate images of cards we already know
		this.myUnknownCards := this.RegisterCards(this.myPathToDeck "\Unknown", true)		
	}
	
	RegisterCards(path, alwaysRegister)
	{
		myTempCards := Object()
		
		Loop, %path%\*.jpg, 0, 0
		{
			myCard := new Card(A_LoopFileName, A_LoopFileFullPath)
			
			; Check validity of Card
			if (not(myCard.isValid) && not(alwaysRegister))
			{
				;Warn about files out of format.
				this.myLogger.log(myCard.inValidReason)
			}
			else ; we have a valid card, add it to the deck
			{
				myTempCards.Insert(myCard)
			}
		}
		
		return myTempCards
	}
	
	FindCardOnScreen(x, y, w, h)
	{	
		foundImage := false
		myImageMapper := new ScreenMapper(x,y,w,h)
		
		for myCard in myCardArray
		{
			if (myImageMapper.FindImage(myCard.FileFullImage))
			{
				foundImage := true
				return myCard
			}
		}
		screen := this.x "|" this.y "|" this.w "|" this.h
		filename := PathToDeck "\Unknown\" A_Now ".png"
		Screenshot(filename, screen)
		return false
	}
}