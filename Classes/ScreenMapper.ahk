#Include %A_ScriptDir%\lib\gdip.ahk
#Include %A_ScriptDir%\lib\gdip-util.ahk

class ScreenMapper
{
	isInitialized := false
	x := 0
	y := 0
	w := 0
	h := 0
	
	__New()
	{		
		isInitialized := true
	}
	
	SetRect(x, y, w, h)
	{
		this.x := x
		this.y := y
		this.w := w
		this.h := h
	}
	
	FindImage(ImageFileName)
	{
		ImageSearch, FoundX, FoundY, x, y, x+w, y+h, %ImageFileName%
		
		if (ErrorLevel == 0)
		{
			return true
		}
		else if (ErrorLevel ==1)
		{
			return false
		}
		else
		{
			throw exception "could not load image " . ImageFileName
		}
	}
}