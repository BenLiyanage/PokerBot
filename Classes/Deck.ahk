

Class Deck 
{
	myCards := new Array()
	
	myPathToDeck := ""
	
	myLogger := ""
	
	__New(PathToDeck, Logger)
	{
		this.myPathToDeck := PathToDeck
		this.myLogger := Logger
				
		Loop, this.PathToDeck, 0, 0
		{
			myCard := new Card(A_LoopFileName, A_LoopFileFullPath)
			
			; Check validity of Card
			if (not(myCard.isValid))
			{
				;Warn about files out of format.
				myLogger.log(myCard.inValidReason)
			}
			else ; we have a valid card, add it to the deck
			{
				myCards.Insert(myCard)
			}
		}
		
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
		;msgBox(ImageFileNameArray.MaxIndex())
		
	}
}