rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
rem SET PATH=%CD%\..\..\ext;%CD%\..\..\MinGW\bin;%CD%\..\..\python\python-3.7.4-embed-win32;%PATH%
SET PATH=%CD%\..\..\ext;%CD%\..\..\python\python-3.7.4-embed-win32;%PATH%
rem rd %1_compiled /s /q
rd __pycache__ /s /q
python -m compileall %1.py -f
rem xcopy __pycache__ %1_compiled\ /s /e /y /q
xcopy __pycache__ /s /e /y /q
rd __pycache__ /s /q
pause
endlocal