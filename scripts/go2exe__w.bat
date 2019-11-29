rem ###########################
rem  N.Kozak // Lviv'2019
rem ############################

setlocal 
SET PATH=%CD%\..\..\MinGW\bin;%CD%\..\..\go\bin;%PATH%
go build %1.go 
pause
endlocal