@echo off

REM *******************************************************
REM *           SET THE NAME OF YOUR PK3 BELOW            *
REM *******************************************************



set pk3name=myproj



REM *******************************************************
REM *                 COMPILE THE PK3                     *
REM *******************************************************




if exist %pk3name%.pk3 del %pk3name%.pk3

call compile.bat

cd ..\

7z a -r -x!src\ -x!acs\*.acs -x!maps\*.o -x!maps\*.acs -x!dialogs\ -x!*.dbs -x!*.bat -x!*.bak -x!*.backup* -x!*.db -ssw -tzip ..\%pk3name%.pk3 "*" 