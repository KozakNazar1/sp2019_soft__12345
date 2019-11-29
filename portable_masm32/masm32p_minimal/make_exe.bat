@echo off
cls

@SET PATH=C:\Masm32\bin

masm32\bin\ML /nologo -c -coff %1.asm
if errorlevel 1 goto terminate

masm32\bin\LINK /nologo %1.obj /SUBSYSTEM:WINDOWS /STUB:64stub.exe /FILEALIGN:512 /VERSION:4.0 /MERGE:.rdata=.text /ignore:4078 /RELEASE /BASE:0x400000

if errorLevel 1 goto terminate

echo OK

:terminate