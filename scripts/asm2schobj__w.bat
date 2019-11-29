rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\MinGW\bin;%PATH%
CALL gcc -m64 -shared -o %1.so -fPIC %1.s
rem rem CALL gcc -shared -o %1.so -fPIC %1.s
rem gcc -v
pause
endlocal