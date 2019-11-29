rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET BASE_DIR_OFFSET=..\..
SET PATH=%CD%\%BASE_DIR_OFFSET%\ext;%CD%\%BASE_DIR_OFFSET%\Java\jdk1.8.0_221\bin;%PATH%
rem SET COOMMAND_TO_RUN=jar -cfm server.jar manifest.mf server.class
SET COOMMAND_TO_RUN=jar cfm server.jar manifest.mf server.class
rem dir "%CD%\MANIFEST.MF" /a-D 2>nul >nul || SET COOMMAND_TO_RUN=jar -cfv server.jar server.class
dir "%CD%\MANIFEST.MF" /a-D 2>nul >nul || SET COOMMAND_TO_RUN=jar cfv server.jar server.class
CALL %COOMMAND_TO_RUN%
endlocal