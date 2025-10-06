@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

set AIR_TARGET=
set OPTIONS=
call bat\Packager.bat

n:: Ensure debug file exists (create parent folders then an empty file)
if not exist "bin\Swivel\META-INF\AIR" md "bin\Swivel\META-INF\AIR"
type nul > "bin\Swivel\META-INF\AIR\debug"
