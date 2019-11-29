rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PROJECT_DIR=%CD%
SET BASE_DIR_OFFSET=..\..
SET PATH=%PROJECT_DIR%;%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\MinGW\bin;%CD%\%BASE_DIR_OFFSET%\python\python-3.7.4-embed-win32;%CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86;%PATH%
SET PYTHON=%CD%\%BASE_DIR_OFFSET%\python\python-3.7.4-embed-win32;
xcopy .\* %CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86 /y /q
cd %CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86
CALL node-gyp rebuild
cd %PROJECT_DIR%
rd node_modules /s /q
rd build /s /q
xcopy %CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86\node_modules\bindings node_modules\bindings\ /s /e /y /q
xcopy %CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86\build build\ /s /e /y /q
endlocal