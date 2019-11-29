rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PATH=..\..\MinGW\bin;%PATH%
for /F "tokens=*" %%A in (%~1.prj) do g++ %%A -o %1.exe -static-libgcc -static-libstdc++
pause
endlocal