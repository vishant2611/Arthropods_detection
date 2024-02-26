@echo off
setlocal enabledelayedexpansion

rem Define source and destination folders
set "source=<Path>"
set "destination=<Path>"

rem Set the number of random images to select
set /a "num_images=250"

rem Change directory to source folder
pushd "%source%"

rem Create a list of files in the source directory
dir /b /a-d > files.txt

rem Count the number of files in the directory
for /f %%i in ('type files.txt ^| find /c /v ""') do set "file_count=%%i"

rem Check if the number of files is less than the number of images required
if %file_count% lss %num_images% (
    echo Not enough images in the folder.
    pause
    exit /b
)

rem Initialize counter
set "count=0"

:select_images
rem Select random files
set /a "rand=%random% %% file_count"
for /f "skip=%rand% delims=" %%f in (files.txt) do (
    rem Copy selected file to the destination folder
    xcopy "%%f" "%destination%\" /y
    rem Increment counter
    set /a "count+=1"
    rem Check if desired number of images has been copied
    if !count! equ %num_images% goto :done
)

:done
echo %num_images% random images have been copied to the destination folder.
pause
popd