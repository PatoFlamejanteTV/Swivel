@echo off
echo START DEBUG STEPS
echo CALLING SetupSDK.bat
call bat\SetupSDK.bat
echo AFTER SetupSDK.bat
echo CALLING SetupApplication.bat
call bat\SetupApplication.bat
echo AFTER SetupApplication.bat
echo CALLING Packager.bat
call bat\Packager.bat
echo AFTER Packager.bat
echo END DEBUG STEPS
