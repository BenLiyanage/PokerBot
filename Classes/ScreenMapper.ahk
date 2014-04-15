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
			; could not find image.
			; take a screen shot of the selected area for later analysis
			
			
			
			return false
		}
		else
		{
			throw exception "could not load image " . ImageFileName
		}
	}
	
	FindImages(ImageFileNameArray)
	{	
		foundImage := false
		for ImageFileName in ImageFileNameArray
		{
			if (this.FindImage(ImageFileName))
			{
				foundImage := true
				return true
			}
		}
		screen := this.x "|" this.y "|" this.w "|" this.h
		filename := A_ScriptDir "\Assets\Unknown\" A_Now ".png"
		Screenshot(filename, screen)
		return false
		;msgBox(ImageFileNameArray.MaxIndex())
		
	}
}