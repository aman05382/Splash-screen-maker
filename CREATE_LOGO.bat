@echo off
echo.---------------------------------------------------
echo.Lenovo Vibe K5 PLUS Splash Image Maker
echo.
echo.(This is for K5 PLUS only)
echo.
echo.	********************
echo.---------------------------------------------------
echo. Choose from the list given below:
echo.
echo. [1] Lenovo Vibe K5=720p
echo. [2] Lenovo Vibe K5=1080p
echo.
echo.

set /a one=1
set /a two=2
set input=
set /p input= Enter your choice:
if %input% equ %one% goto case_720p 
if %input% equ %two% goto case_1080p
::==========================================================================================================
:case_720p
set resolution=720x1280

if not exist "output\" mkdir "output\"
del /Q output\splash-720p.img 2>NUL
del /Q output\flashable_splash-720p.zip 2>NUL

::VERIFY_FILES
if not exist "pics\logo-720p.png" echo.logo-720p.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit
if not exist "pics\fastboot-720p.png" echo.fastboot-720p.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit

::CONVERT_TO_RAW
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\logo-720p.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash1.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\fastboot-720p.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash2.raw" > NUL

::JOIN_ALL_RAW_FILES
:: Below is the default splash header for all pictures
set H="bin\%resolution%_header720.img"
copy /b %H%+"output\splash1.raw"+%H%+"output\splash2.raw" output\splash-720p.img >NUL
del /Q output\*.raw


if exist "output\splash-720p.img" ( echo.SUCCESS!&echo.splash.img created in "output" folder
) else (echo.PROCESS FAILED.. Try Again&echo.&echo.&pause&exit)

echo.&echo.&set /P INPUT=Do you want to create a flashable zip? [yes/no]
If /I "%INPUT%"=="y" goto :CREATE_ZIPP
If /I "%INPUT%"=="yes" goto :CREATE_ZIPP

echo.&echo.&echo Flashable ZIP not created..&echo.&echo.&pause&exit

:CREATE_ZIPP
copy /Y bin\New_Splash.zip output\flashable_splash-720p.zip >NUL
cd output
..\bin\7za a flashable_splash-720p.zip splash.img >NUL
cd..

if exist "output\flashable_splash-720p.zip" (
 echo.&echo.&echo.SUCCESS!
 echo.Flashable zip file created in "output" folder
 echo.You can flash the flashable_splash.zip from any custom recovery like TWRP or CWM or Philz
) else ( echo.&echo.&echo Flashable ZIP not created.. )

echo.&echo.&pause&exit
::============================================================================================================
:case_1080p
set resolution=1080x1920

if not exist "output\" mkdir "output\"
del /Q output\splash-1080p.img 2>NUL
del /Q output\flashable_splash-1080p.zip 2>NUL

::VERIFY_FILES
if not exist "pics\logo-1080p.png" echo.logo-1080p.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit
if not exist "pics\fastboot-1080p.png" echo.fastboot-1080p.png not found in 'pics' folder.. EXITING&echo.&echo.&pause&exit

::CONVERT_TO_RAW
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\logo-1080p.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash1.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i pics\fastboot-1080p.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -s %resolution% -y "output\splash2.raw" > NUL

::JOIN_ALL_RAW_FILES
:: Below is the default splash header for all pictures
set H="bin\%resolution%_header1080p.img"
copy /b %H%+"output\splash1.raw"+%H%+"output\splash2.raw" output\splash-1080p.img >NUL
del /Q output\*.raw


if exist "output\splash-1080p.img" ( echo.SUCCESS!&echo.splash.img created in "output" folder
) else (echo.PROCESS FAILED.. Try Again&echo.&echo.&pause&exit)

echo.&echo.&set /P INPUT=Do you want to create a flashable zip? [yes/no]
If /I "%INPUT%"=="y" goto :CREATE_ZIP
If /I "%INPUT%"=="yes" goto :CREATE_ZIP

echo.&echo.&echo Flashable ZIP not created..&echo.&echo.&pause&exit

:CREATE_ZIP
copy /Y bin\New_Splash.zip output\flashable_splash-1080p.zip >NUL
cd output
..\bin\7za a flashable_splash-1080p.zip splash.img >NUL
cd..

if exist "output\flashable_splash-1080p.zip" (
 echo.&echo.&echo.SUCCESS!
 echo.Flashable zip file created in "output" folder
 echo.You can flash the flashable_splash.zip from any custom recovery like TWRP or CWM or Philz
) else ( echo.&echo.&echo Flashable ZIP not created.. )

echo.&echo.&pause&exit

