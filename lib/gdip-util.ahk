/*
 * Utility Functions for using gdip
*/

#Include %A_ScriptDir%\lib\gdip.ahk

/* 
 * Example Usage 
 */

if (A_ScriptName == "gdip-util.ahk")
{
	file := A_ScriptDir "\" A_Now ".PNG"
	screen :=  "0|0|" . A_ScreenWidth . "|" . A_ScreenHeight ; X|Y|W|H
	Screenshot(file,screen)
	return
}

Screenshot(outfile, screen) ; Save screenshot from defined coordinates.
{
   pToken := Gdip_Startup()
   raster := 0x40000000 + 0x00CC0020

   pBitmap := Gdip_BitmapFromScreen(screen,raster)

   returnValue := Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
   if (returnValue != 0)
		throw new Exception("Unable to write file")
   Gdip_DisposeImage(pBitmap)
   Gdip_Shutdown(pToken)
   
   
}
