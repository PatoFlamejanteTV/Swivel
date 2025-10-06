@echo off
echo === RUN PACKAGER VERBOSE ===
echo Running SetupSDK.bat
call bat\SetupSDK.bat
echo SDK_BIN=%SDK_BIN%
echo AIR_SDK=%AIR_SDK%
echo Running SetupApplication.bat
call bat\SetupApplication.bat
echo CERT_FILE=%CERT_FILE%
echo SIGNING_OPTIONS=%SIGNING_OPTIONS%
echo APP_DIR=%APP_DIR%
echo APP_XML=%APP_XML%
echo Now calling Packager.bat
call bat\Packager.bat
echo Packager returned %ERRORLEVEL%
