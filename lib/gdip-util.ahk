/*
 * Utility Functions for using gdip
 * 
 *
 *
*/

/* 
 * Example Usage 
 */
 
If(A_ScriptName="gdip-util.ahk")
{
	file := A_ScriptDir "\Screenshots\" A_Now ".png"
	Sleep, 100
	ScreenshotFromClipboard(file)
	return

	F1::
	file := A_ScriptDir "\Screenshots\" A_Now ".png"
	screen := "100|200|300|200" ; X|Y|W|H
	Screenshot(file,screen)
	return
}

ScreenshotFromClipboard(outfile) ; Save screenshot from clipboard.
{
	pToken := Gdip_Startup()

	pBitmap := Gdip_CreateBitmapFromClipboard()

	Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}

Screenshot(outfile, screen) ; Save screenshot from defined coordinates.
{
	pToken := Gdip_Startup()
	raster := 0x40000000 + 0x00CC0020

	pBitmap := Gdip_BitmapFromScreen(screen,raster)

	Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}