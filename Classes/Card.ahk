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
		
		if (len != 6)
		{
			this.inValidReason := "Not a valid filename: " this.FileName "; Expected length of 6;  Got length of " len
			return this
		}
		
		this.Rank := SubStr(this.FileName, 1, 1)
		this.Suit := SubStr(this.FileName, 2, 1)
		
		this.RankPosition := InStr(this.ValidRanks, this.Rank)
		if (this.RankPosition == 0)
		{
			this.inValidReason := "Not a valid rank.  Rank found: " this.Rank "; Rank expected: " this.ValidRanks "."
			return this
		}
		
		suitPosition := InStr(this.ValidSuits, this.Suit)
		if (suitPosition == 0)
		{
			this.inValidReason := "Not a valid Suit.  Suit found: " this.Suit "; SuitPosition: " suitPosition "; Suit expected: " this.ValidSuits "."
			return this
		}
		
		this.isValid := true 
		return this
	}
}