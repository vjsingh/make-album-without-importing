on run
	set folderList to (choose folder with multiple selections allowed)
	
	tell application "Photos"
		activate
		delay 2
	end tell
	
	repeat with baseFolder in folderList
		importFotos(baseFolder, "NEW ALBUM")
	end repeat
end run

on importFotos(aFolder, albumName)
	set imageList to getImageList(aFolder)
	log (albumName)
	if imageList is {} then return
	
	set fotoAlbum to createFotoAlbum(albumName)
	
	repeat with image in imageList
		set fileInfo to info for image
		set filename to name of fileInfo
		set filenameStr to filename as string
		log (filename)
		
		tell application "Photos"
			activate
			set photosImage to search for filenameStr
			add photosImage to fotoAlbum
			log (photosImage)
			
		end tell
		
		
	end repeat
	log (albumName)
	
end importFotos

on getImageList(aFolder)
	set extensionsList to {"jpg", "png", "tiff", "JPG", "jpeg", "gif", "JPEG", "PNG", "TIFF", "GIF", "MOV", "mov", "MP4", "mp4", "M4V", "m4v", "MPG", "mpg", "BMP", "bmp", "TIF", "tif", "AVI", "avi", "PSD", "psd", "ai", "AI", "orf", "ORF", "nef", "NEF", "crw", "CRW", "cr2", "CR2", "dng", "DNG", "PEF", "HEIC"}
	with timeout of (30 * 60) seconds
		tell application "Finder" to set theFiles to every file of aFolder whose name extension is in extensionsList
	end timeout
	set imageList to {}
	repeat with i from 1 to number of items in theFiles
		set thisItem to item i of theFiles as alias
		set the end of imageList to thisItem
	end repeat
	
	imageList
end getImageList

on createFotoAlbum(albumName)
	tell application "Photos"
		make new album named albumName
	end tell
end createFotoAlbum
