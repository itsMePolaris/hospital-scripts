@echo off

color 0a
title Multiple Script for Schneider Computer (by oriel yelizarov)
:start
echo  ==========================================================================================
echo     _____                                         _____                   _             __ 
echo    / ___/  __  __    ____   ___    _____         / ___/  _____   _____   (_)    ____   / /_
echo    \__ \  / / / /   / __ \ / _ \  / ___/ ______  \__ \  / ___/  / ___/  / /    / __ \ / __/
echo   ___/ / / /_/ /   / /_/ //  __/ / /    /_____/ ___/ / / /__   / /     / /    / /_/ // /_  
echo  /____/  \__,_/   / .___/ \___/ /_/            /____/  \___/  /_/     /_/    / .___/ \__/  
echo                  /_/                                                 /_/    /_/          
echo  ==========================================================================================
echo    Please Choose:
echo ==================================
echo    1 = Open Cupmuters.
echo    2 = gpupdate
echo    3 = Delete Old User Profile.
echo    4 = Temp Deleter.
echo ==================================

set /p chioce=Enter:
IF %chioce% == 1 goto Schneider
IF %chioce% == 2 goto gpupdate
IF %chioce% == 3 goto IPG
IF %chioce% == 4 goto temp

:Schneider
set /p input=Please Enter Computer Name: 
START \\%input%.schneider.clalit.org.il\c$
	goto exit



:temp
	rmdir "c:\Users\Default\AppData\Local\Temp\" /s /q
	FOR /D %%G in ("c:\Users\*") DO (
		echo "%%~nxG"	
		rmdir "c:\Users\%%~nxG\AppData\Local\Temp\" /s /q
	)
:IPG
set /p input=Please Enter IP or Computer Name: 
echo Pinging... Please wait up to 5 seconds
ping -n 1 %input% | find "TTL=" >nul
if errorlevel 1 (
    echo ===NO PING TO SPECIFIED PC=== 
	echo Try Again...
	goto IPG
) else (
		echo You have 10 seconds to choose. Default choice is [N]
		choice /T 10 /D N /M "Are you sure?"
		if errorlevel 2 goto NO 
		if errorlevel 1 goto YESG
	)
:YESG		
    title Deleting Users on: %input%
	C:\Delprof2\Delprof2.exe /c:%input% /u /i /d:90 /ed:Administrator /ed:public /ed:Default /ed:robertch /ed:mastewalwor /ed:dinossov
	echo off 
	echo ###===============DONE==============###
	goto START
:NO
	echo off
	echo                          Choosed No...
	echo                                  ...Wise Choice
	goto START	
)



:gpupdate
c:\windows\system32\gpupdate /force /wait:0
echo DONE
timeout 1
set /p restart=Restart Computer? [y/n]
IF %restart% == y goto rest
IF %restart% == n goto exit
:rest
shutdown /f /r


pause