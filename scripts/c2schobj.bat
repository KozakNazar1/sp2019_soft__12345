rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\MinGW\bin;%PATH%
rem CALL gcc -m32 -shared -o %1.so -fPIC %1.c
rem CALL gcc -shared -o %1.so -fPIC %1.c -Wl,-soname -Wl,--no-whole-archive
CALL gcc -m32 -shared -o %1.so -fPIC %1.c -Wl,-soname -Wl,--no-whole-archive
endlocal