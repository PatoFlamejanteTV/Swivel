:user_configuration

:: Detection order:
:: 1) If AIR_SDK is already defined and looks valid, use it.
:: 2) Try to find 'adt' on the PATH (where adt).
:: 3) Try a common Downloads location.
:: 4) As a last resort, use the historical default if it exists.

:: (1) If AIR_SDK is already set, don't overwrite it here - validation follows.

:: (2) Try to find adt on the system PATH (adt.exe)
for /f "delims=" %%A in ('where adt 2^>nul') do set ADT_FULL=%%A
if defined ADT_FULL (
	rem ADT_FULL is the full path to adt.exe (e.g. C:\...\bin\adt.exe)
	for %%I in ("%ADT_FULL%") do set SDK_BIN=%%~dpI
)

:: (3) Try a common Downloads location if nothing found yet
if not defined SDK_BIN if exist "%USERPROFILE%\Downloads\AdobeAIRSDK\bin\adt.exe" set SDK_BIN=%USERPROFILE%\Downloads\AdobeAIRSDK\bin

:: (4) If AIR_SDK was set by the environment and points to either root or bin we will validate it later
:: If nothing was found yet, try a historical default only if it exists
if not defined SDK_BIN if not defined AIR_SDK if exist "C:\AIR\AIRSDK_51.2.2\bin\adt.exe" set AIR_SDK=C:\AIR\AIRSDK_51.2.2

:validation
:: Accept either AIR_SDK pointing at the SDK root (contains a \bin folder)
:: or pointing directly at the bin folder itself.
:: If we already determined SDK_BIN from 'where adt' or Downloads, accept it.
if defined SDK_BIN goto succeed

if defined AIR_SDK (
	if exist "%AIR_SDK%\bin\adt.exe" (
		set SDK_BIN=%AIR_SDK%\bin
		goto succeed
	)
	if exist "%AIR_SDK%\adt.exe" (
		set SDK_BIN=%AIR_SDK%
		goto succeed
	)
)
goto flexsdk

:flexsdk
echo.
echo ERROR: Path to Adobe AIR SDK not found.
echo Please set the AIR_SDK environment variable to the SDK root (the folder that contains the "bin" folder),
echo or install the Adobe AIR SDK and ensure the "adt" tool is available on your PATH.
echo Examples:
echo   setx AIR_SDK "C:\\Users\\you\\Downloads\\AdobeAIRSDK"
echo   or add the SDK bin folder to PATH so "adt.exe" is discoverable.
echo.
if "%PAUSE_ERRORS%"=="1" pause
exit /b 1

:succeed
rem Add the resolved SDK bin directory to PATH for packaging commands
if not defined SDK_BIN (
	if exist "%AIR_SDK%\bin" (
		set SDK_BIN=%AIR_SDK%\bin
	) else set SDK_BIN=%AIR_SDK%
)
set PATH=%PATH%;%SDK_BIN%

