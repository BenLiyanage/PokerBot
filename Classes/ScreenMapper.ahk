#Include %A_ScriptDir%\lib\gdip.ahk

class ScreenMapper
{
	isInitialized := false
	x := 0
	y := 0
	w := 0
	h := 0
	
	__New(x=0,y=0,w=0,h=0)
	{		
		isInitialized := true
		this.SetRect(x,y,w,h)
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

	Screenshot(outfile) ; Save screenshot from defined coordinates.
	{
		screen := this.x "|" this.y "|" this.w "|" this.h 
		
		pToken := Gdip_Startup()
		raster := 0x40000000 + 0x00CC0020

		pBitmap := Gdip_BitmapFromScreen(screen,raster)

		returnValue := Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
		if (returnValue != 0)
		{
			throw "Unable to write file. returnValue: " returnValue
		}
		
		Gdip_DisposeImage(pBitmap)
		Gdip_Shutdown(pToken)
	}
}