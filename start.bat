@echo off

call:show_header

set port=27015

set players=16
set gamemode=sandbox
set map=gm_construct
set tickrate=66

set apikey=
set gskey=

set workshop=
set loadingurl=

call:show_info

echo - [94mPress ENTER to start server[0m

pause >nul
call:state_restart
call:restart

:show_header

    echo - [91mBulka Dev Starter[0m
    title Bulka Dev

    timeout /nobreak /t 1 >nul

exit /b 0

:show_info

    echo.
    echo + [90mUp to %players% players on[0m
    echo + [90m%map% in %gamemode%[0m
    echo + [90mwith %tickrate% ticks per second[0m
    echo.
    echo + [90mIP: localhost:%port%[0m
    echo.

    timeout /nobreak /t 1 >nul

exit /b 0


:state_restart

    cls
    call:show_header
    call:show_info

    tasklist /FI "IMAGENAME eq srcds.exe" 2>nul | find /I /N "srcds.exe">nul
    if "%ERRORLEVEL%"=="0" (
        taskkill /f /im srcds.exe >nul
        echo - [93mRestarting srcds.exe[0m
        title Bulka Dev / Restarting
    ) else ( 
        echo - [93mStarting srcds.exe[0m
        title Bulka Dev / Starting
    )

    timeout /nobreak /t 1 >nul

exit /b 0

:state_done

    echo - [32mDone[0m
    title Bulka Dev / Done

    timeout /nobreak /t 1 >nul

    echo - [94mPress ENTER to restart server[0m

exit /b 0

:restart
    
    start srcds.exe -tickrate %tickrate% -port %port% -console -game "garrysmod" +gmod_language "ru" +sv_setsteamaccount %gskey% -authkey %apikey% +host_workshop_collection %workshop% +gamemode %gamemode% +map %map% +maxplayers %players% +sv_loadingurl %loadingurl%

    call:state_done

    pause >nul

    call:state_restart
    call:restart

exit /b 0
