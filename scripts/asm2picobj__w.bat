rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PATH=..\..\MinGW\bin;%PATH%
gcc -c -fPIC %1.s 
pause
endlocal