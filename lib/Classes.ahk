; Classes for tracking stats

class Game
{
	/* 
	* objects to track
	*/
	Player := new Array()
	HandHistory := new Array()
	CurrentHand := ""
	MyPosition := 0
	
	__New(Players, Hand, MyPosition)
	{
		; An Array of Players.  Players should be in the order they play hands
		this.Player := Players
		this.CurrentHand := Hand
		this.MyPosition := MyPosition
	}
	
	AddPlayer(Player, Position)
	{
		this.Player.Insert(Position, Player)
	}
	
	RemovePlayer(Position)
	{
		return this.Player.Remove(Position)
	}
	
	PreFlopAction()
	{
		if CurrentHand = ""
			throw exception("No hand is currently initialized")
		
		if ShouldIBet()
		{
			Bet()
		}
		else
		{
			Pass()
		}
	}
	
	ShouldIBet()
	{
		; Returns true if the hand should be bet.
		throw new exception("Not implemented")
	
		return false
	}
	
	Bet()
	{
		throw exception("Not implemented")
	}
	
	Pass()
	{
		throw exception("Not implemented")
	}
	
}
 
class Hand
{
	; Add things as necessary here
	; Hole = Array()
	
}

class Player
{
	
}