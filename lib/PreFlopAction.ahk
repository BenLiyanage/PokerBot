/*
 * Function for determining whether to bet or fold on preflop action
 *
 */
 
class Game
{
	/* 
	* objects to track
	*/
	Player = Array()
	Hand = Array()
	
	__New(Players)
	{
		; An Array of Players.  Players should be in the order they play hands
		this.Player = Players
	}
	
	AddPlayer(Player, Position)
	{
		this.Player.Insert(Position, Player)
	}
	
	RemovePlayer(Position)
	{
		return this.Player.Remove(Position)
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

PreFlopAction()