rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\Java\jdk1.8.0_221\bin;%CD%\%BASE_DIR_OFFSET%\javadecompiler\jd-gui-windows-1.6.3;%PATH%
jd-gui %1.class
endlocal