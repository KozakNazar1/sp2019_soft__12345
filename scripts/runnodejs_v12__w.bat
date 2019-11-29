rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\node\node-v12.11.0-win-x86;%PATH%
node %1.js
pause
endlocal