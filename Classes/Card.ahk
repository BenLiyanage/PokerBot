/*
 * Description: A class for initializing a card from a filename.  Full path is also stored so the image can be retrieved later.
 */
Class Card
{
	ValidSuits := "CSDH" ; Clubs | Spades | Diamonds | Hearts
	ValidRanks := "234567890JQKA" ; 2-9, 0 is 10, Jack, Queen, King, Ace respectively.
	
	Rank := ""
	RankPosition :=
	Suit := ""
	
	FileName := ""
	FileFullPath := ""
	
	isValid := false
	inValidReason := ""
	
	__New(FileName, FileFullPath)
	{
		this.FileName := FileName
		this.FileFullPath := FileFullPath
		
		; Expecting Rank, then Suit, then ".jpg" as the filename.
		; Examples: 2S.jpg = Two of Spades, AH.jpg = Ace of Hearts
		
		; Basic Validation
		len := StrLen(this.FileName)		
		if (len != 5)
		{
			this.inValidReason := "Not a valid filename: " this.FileName "; Expected RS.jpg, where R is one of " this.ValidRanks " and S is one of " this.ValidSuits "."
			return 
		}
		
		this.Rank := SubStr(this.FileName, 1, 1)
		this.Suit := SubStr(this.FileName, 2, 1)
		
		this.RankPosition := InStr(this.ValidRanks, Rank)
		if (this.RankPosition == 0)
		{
			this.inValidReason := "Not a valid rank.  Rank found: " this.Rank "; Rank expected: " this.ValidRanks "."
			return
		}
				
		if (InStr(ValidSuit, this.Suit) == 0)
		{
			this.inValidReason := "Not a valid Suit.  Suit found: " this.Suit "; Suit expected: " this.ValidSuits "."
			return
		}		
	}
}