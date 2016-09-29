@ECHO off
SETLOCAL
GOTO Options

Martin's Rad Dad Admin t00lz ver 1.0
Last update - 9/29/2016

TO DO
- Input/error handling
- Extend to other applications as needed
- create dll options
- Optimize/clean up coding

:Options
REM Command choice
ECHO.
ECHO =-=-=-=-=-=-=--=-=-=
ECHO  Rad Dad Admin Tool
ECHO =-=-=-=-=-=-=--=-=-=
ECHO 1) Install/Remove Programs/Features
ECHO 2) Device Management
ECHO 3) Local User and Group Manager
ECHO 4) Network Connections
ECHO 5) System Properties
ECHO 6) MMC
ECHO.
ECHO Type "Help" to bring up these options.
ECHO Type "Exit" to quit program.

:Select
ECHO.
set choice=
set /p choice=Enter your t00l:

IF [%choice%]==[] (
   ECHO No input found!
   GOTO Select
   )
IF %choice%==1 set command=appwiz.cpl
IF %choice%==2 set command=DeviceManager_Execute
IF %choice%==3 set command=lusrmgr.msc
IF %choice%==4 set command=ncpa.cpl
IF %choice%==5 set command=sysdm.cpl
IF %choice%==6 set command=mmc
IF /I %choice%==help GOTO Options
IF /I %choice%==exit (
   ECHO.
   ECHO l8r d00d!!
   GOTO End
   )

REM Username and host/domain prompt
set /p user=Enter your username (or leave blank for desktopadmin): 
set host=Regents
IF [%user%]==[] (
   set user=desktopadmin
   set host=%COMPUTERNAME%
   )

REM Run As Execution (password prompt happens here)
IF %choice%==2 (
   runas /user:%host%\%user% "RunDll32.exe devmgr.dll %command%"
   GOTO Select
   )
IF %choice%==3 (
   runas /user:%host%\%user% "mmc %systemroot%\system32\%command%"
   GOTO Select
   )
IF %choice%==6 (
   runas /user:%host%\%user% %command%
   GOTO Select
   )
runas /user:%host%\%user% "rundll32.exe shell32.dll,Control_RunDLL %command%"
GOTO Select

:End
ECHO.