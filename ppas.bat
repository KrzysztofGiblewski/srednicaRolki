@echo off
SET THEFILE=C:\LazarusMojeProjekty2\SrednicaRolki\SrednicaRolki.exe
echo Linking %THEFILE%
C:\lazarus32bity\fpc\3.0.4\bin\i386-win32\ld.exe -b pei-i386 -m i386pe  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\LazarusMojeProjekty2\SrednicaRolki\SrednicaRolki.exe C:\LazarusMojeProjekty2\SrednicaRolki\link.res
if errorlevel 1 goto linkend
C:\lazarus32bity\fpc\3.0.4\bin\i386-win32\postw32.exe --subsystem gui --input C:\LazarusMojeProjekty2\SrednicaRolki\SrednicaRolki.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
