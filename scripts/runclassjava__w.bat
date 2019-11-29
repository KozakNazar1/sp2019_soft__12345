rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\Java\jdk1.8.0_221\bin;%PATH%
rem @ECHO OFF
FOR %%i IN (%1) DO (
rem ECHO filedrive=%%~di
rem ECHO filepath=%%~pi
SET filename=%%~ni
rem ECHO fileextension=%%~xi
)
CALL java %filename%
pause
endlocal