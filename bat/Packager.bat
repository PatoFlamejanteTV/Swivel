@echo on
echo DEBUG: Start Packager.bat
:: Preflight: ensure required variables are defined (normally set by SetupApplication.bat)
echo DEBUG: Check CERT_FILE
if not defined CERT_FILE (
    echo.
    echo ERROR: CERT_FILE is not defined. Run 'PackageApp.bat' from the project root or call 'bat\SetupApplication.bat' first.
    if "%PAUSE_ERRORS%"=="1" pause
    exit /b 1
)

echo DEBUG: Check CERT_FILE exists
if not exist %CERT_FILE% goto certificate

echo DEBUG: Ensure output directory exists
if not exist "%AIR_PATH%" md "%AIR_PATH%"
set OUTPUT=%AIR_PATH%\%AIR_NAME%%AIR_TARGET%.air

echo DEBUG: Check for main SWF
if not exist "%APP_DIR%\Swivel.swf" (
	echo.
	echo ERROR: Required SWF not found: "%APP_DIR%\Swivel.swf"
	echo The packager expects the application binary at that path - see application.xml -> content element.
	echo To produce this file build the project first. You can usually build with Haxe using the provided HXML:
	echo.
	echo   haxe Swivel.hxml
	echo.
	echo Note: this project was written for Haxe 3.x and may fail to compile with Haxe 4. If you get Haxe errors,
	echo consider installing a Haxe 3.x toolchain or building from FlashDevelop.
	echo.
	if "%PAUSE_ERRORS%"=="1" pause
	exit /b 1
)

echo DEBUG: About to package
echo Packaging %AIR_NAME%%AIR_TARGET%.air using certificate %CERT_FILE%...
call adt -package %SIGNING_OPTIONS% -target bundle "%OUTPUT%" "%APP_XML%" -C "%APP_DIR%" . ffmpeg\win32 ffmpeg\licenses assets\icons README.md LICENSE.md
if errorlevel 1 goto failed
goto end


:certificate
echo DEBUG: Certificate not found
echo.
echo Certificate not found: %CERT_FILE%
echo.
echo Troubleshooting:
echo - generate a default certificate using 'bat\CreateCertificate.bat'
echo.
if "%PAUSE_ERRORS%"=="1" pause
exit


:failed
echo DEBUG: Packaging failed
echo AIR setup creation FAILED.
echo.
echo Troubleshooting:
echo - did you build your project in FlashDevelop?
echo - verify AIR SDK target version in %APP_XML%
echo.
if "%PAUSE_ERRORS%"=="1" pause
exit


:end
echo DEBUG: End Packager.bat
echo.