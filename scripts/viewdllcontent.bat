rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\dllexp;%PATH%
dllexp %1.dll
endlocal