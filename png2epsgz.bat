@ECHO 	OFF
REM
REM	This file is a Windows script to convert an image to .eps.gz (with additional .bb 
REM	file for the bounding box information). REM	The reason I wrote this script
REM	is because most conferences (at least in graphics/visualization areas) 
REM	recommend compiling .tex file with LaTeX, which supports only .eps. Using 
REM	.eps for rasterized images (.JPG or .PNG), nevertheless, can be space 
REM	consuming. Although it is possible to use .eps.gz, additional setup is needed.
REM
REM	The following is the  procedure to use .eps.gz. My script is for the last three steps: 
REM    1.	Install grep.
REM    2.	Add the following rule at the beginning of the LaTeX files after the library graphix is included:
REM        \DeclareGraphicsExtensions{.eps,.eps.gz}
REM        \DeclareGraphicsRule{.eps.gz}{eps}{.bb}{}
REM    3.	Convert the image, for instance, img.png to .eps
REM        convert img.png img.eps
REM    4.	Extract the BoundingBox
REM        grep "%%BoundingBox" img.eps > img.bb
REM    5.	Compress the .eps file
REM        gzip -9 img.eps
REM
REM	With this script, the later 3 steps can be done by a single command:
REM		png2epsgz.bat	img.png
REM	
REM	Note that my program can also work for .eps file:
REM	
REM	Teng-Yok Lee 
REM	recheliu@gmail.com

SETLOCAL
SET 	p=%1
SET		pn=%~n1
SET 	en=%~x1
IF NOT "%en%" == ".eps" convert %p% %pn%.eps
grep "%%BoundingBox" %pn%.eps > %pn%.bb
gzip -9 -f %pn%.eps
ECHO	%p% is converted to %pn%.eps.gz
ENDLOCAL

