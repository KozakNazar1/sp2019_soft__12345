rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PATH=..\..\MinGW\bin;%PATH%
g++ %1.cpp -o %1.exe -static-libgcc -static-libstdc++
pause
endlocal