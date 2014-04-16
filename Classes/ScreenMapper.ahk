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
		ImageSearch, FoundX, FoundY, this.x, this.y, this.x + this.w, this.y + this.h, *100 %ImageFileName%
		
		if (ErrorLevel == 0)
		{
			return true
		}
		else if (ErrorLevel ==1)
		{
			; could not find image
			return false
		}
		else
		{
			throw exception "could not load image " . ImageFileName
		}
	}

	Screenshot(outfile) ; Save screenshot from defined coordinates.
	{
		WinGetActiveStats, Title, Width, Height, winX, winY
		screen := this.x + winX "|" this.y + winY "|" this.w "|" this.h 
		
		pToken := Gdip_Startup()
		raster := 0x00CC0020
		; 
		; From MSDN: http://msdn.microsoft.com/en-us/library/aa930997.aspx
		; SRCCOPY = 0x00CC0020
		; SRCCOPY = Copies the source rectangle directly to the destination rectangle.		
		; See MSDN for additional options.
		; Hex values for additional options are in gdip.ahnk in desription for BitBlt function.

		pBitmap := Gdip_BitmapFromScreen(screen, raster)

		returnValue := Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
		if (returnValue != 0)
		{
			throw "Unable to write file. returnValue: " returnValue
		}
		
		Gdip_DisposeImage(pBitmap)
		Gdip_Shutdown(pToken)
	}
}