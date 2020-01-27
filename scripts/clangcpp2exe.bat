rem ###########################
rem  N.Kozak // Lviv'2020
rem ############################

setlocal 
SET PATH=..\..\LLVM\bin;%PATH%
clang %1.cpp -o %1.exe
endlocal