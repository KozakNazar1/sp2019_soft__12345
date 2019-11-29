rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\MinGW\bin;%CD%\%BASE_DIR_OFFSET%\python\python-3.7.4-embed-win32;%CD%\%BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86;%PATH%
SET PYTHON=%CD%\%BASE_DIR_OFFSET%\python\python-3.7.4-embed-win32;
cd %BASE_DIR_OFFSET%\node\node-v8.9.4-win-x86
CALL npm install -g node-gyp
CALL npm install node-addon-api bindings
endlocal