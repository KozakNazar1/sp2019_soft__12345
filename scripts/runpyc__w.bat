rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
rem SET PATH=%CD%\..\..\ext;%CD%\..\..\MinGW\bin;%CD%\..\..\python\python-3.7.4-embed-win32;%PATH%
SET PATH=%CD%\..\..\ext;%CD%\..\..\python\python-3.7.4-embed-win32;%PATH%
python %1.pyc 
pause
endlocal