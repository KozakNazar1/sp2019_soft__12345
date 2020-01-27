rem ###########################
rem  N.Kozak // Lviv'2020
rem ############################

setlocal 
SET PATH=..\..\LLVM\bin;%PATH%
clang %1.c -o %1.exe -Wno-bitwise-op-parentheses -Wno-logical-op-parentheses
pause
endlocal