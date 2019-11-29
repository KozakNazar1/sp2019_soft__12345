rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PATH=..\..\MinGW\bin;%PATH%
gcc -S %1.c 
pause
endlocal