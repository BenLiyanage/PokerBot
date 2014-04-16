

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
	
	FindCard(x, y, w, h)
	{	
		foundImage := false
		myScreenMapper := new ScreenMapper(x,y,w,h)
		
		myCard := this.FindCardArray(myCards, myImageMapper)
		
		if (myCard != "") ; We found a card, send it back!
		{
			MsgBox found a card
			return myCard
		}
		else
		{
			MsgBox didn't find a card
			myCard := this.FindCardArray(myUnknownCards, myImageMapper)
			
			if (myCard == "") ; We don't know this card.  Let's scrape it for analysis later.
			{
				filename := this.myPathToDeck "\Unknown\" A_Now ".png"
				MsgBox scrapping
				MsgBox % "x coordinate :" myScreenMapper.x
				myScreenMapper.Screenshot(filename)				
			}
			
			; We don't know what this card is.
			return ""
		}
	}
	
	FindCardArray(myCardArray, myImageMapper)
	{
		for myCard in myCardArray
		{
			if (myImageMapper.FindImage(myCard.FileFullImage))
			{
				foundImage := true
				return myCard
			}
		}
		
		return
	}
}