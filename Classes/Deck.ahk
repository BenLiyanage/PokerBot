

Class Deck
{
	myCards := new Array()
	
	myPathToDeck := ""
	
	myLogger := ""
	
	__New(PathToDeck, Logger)
	{
		this.myPathToDeck := PathToDeck
		this.myLogger := Logger
				
		Loop, %this.PathToDeck%, 0, 0
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
}