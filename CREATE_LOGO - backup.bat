@echo off
echo.---------------------------------------------------
echo.Lenovo Vibe K5 PLUS Splash Image Maker
echo.
echo.(This is for K5 PLUS only)
echo.
echo.	By **Gokul NC**
echo.---------------------------------------------------
echo.
echo.
echo.Creating splash.img ........
echo.
echo.
echo.

set resolution=720x1280

if not exist "output\" mkdir "output\"
del /Q output\splash.img 2>NUL
del /Q output\flashable_splash.zip 2>NUL

:VERIFY_FILES
if not exist "pics\logo.png" echo.logo.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit
if not exist "pics\fastboot.png" echo.fastboot.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit

:CONVERT_TO_RAW
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\logo.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash1.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\fastboot.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash2.raw" > NUL

:JOIN_ALL_RAW_FILES
:: Below is the default splash header for all pictures
set H="bin\%resolution%_header.img"
copy /b %H%+"output\splash1.raw"+%H%+"output\splash2.raw" output\splash.img >NUL
del /Q output\*.raw


if exist "output\splash.img" ( echo.SUCCESS!&echo.splash.img created in "output" folder
) else (echo.PROCESS FAILED.. Try Again&echo.&echo.&pause&exit)

echo.&echo.&set /P INPUT=Do you want to create a flashable zip? [yes/no]
If /I "%INPUT%"=="y" goto :CREATE_ZIP
If /I "%INPUT%"=="yes" goto :CREATE_ZIP

echo.&echo.&echo Flashable ZIP not created..&echo.&echo.&pause&exit

:CREATE_ZIP
copy /Y bin\New_Splash.zip output\flashable_splash.zip >NUL
cd output
..\bin\7za a flashable_splash.zip splash.img >NUL
cd..

if exist "output\flashable_splash.zip" (
 echo.&echo.&echo.SUCCESS!
 echo.Flashable zip file created in "output" folder
 echo.You can flash the flashable_splash.zip from any custom recovery like TWRP or CWM or Philz
) else ( echo.&echo.&echo Flashable ZIP not created.. )

echo.&echo.&pause&exit