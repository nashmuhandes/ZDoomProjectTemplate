@echo off

REM Source directory name. DO NOT MODIFY!

set sourcedirname=src




REM *******************************************************
REM *           MODIFY THE VARIABLES BELOW TO SUIT        *
REM *                      YOUR PROJECT                   *
REM *******************************************************




REM Set the path to your game executable (ZDoom, GZDoom, whatever)
REM and the executable itself below.
set exepath=d:\games\doom
set exename=zdoom.exe

REM Set the path to your project below.
set projectpath=d:\games\doom\myproj




REM *******************************************************
REM *           PROCEED TO COMPILE ACS LIBRARIES,         *
REM *                    AND MAP SCRIPTS                  *
REM *******************************************************



REM First, delete all previously compiled libraries
cd %sourcedirname%\acs
del *.o
del error.txt

REM Now let's go to the source directory
cd ../acs_src
del *.o
del error.txt

REM Compile all libraries
for %%v in (*.acs) do (
acc "%%v" ../acs/"%%~nv.o"
REM pause
if exist acs.err ren acs.err error.txt
if exist error.txt goto acserror
)

goto acsnoerror

:acsnoerror

echo ACS compiled successfully.

REM Go to the ACS directory to do some cleaning up
cd ../acs

REM These objects aren't necessary
del zcommon.o
del zdefs.o
del zspecial.o
del zwvars.o

REM Generate the LOADACS
type NUL > ../loadacs.txt
echo // Generated automatically by build script at %TIME% on %DATE%, do not edit>>../loadacs.txt
for %%v in (*.o) do (
echo %%~nv>>../loadacs.txt
)

goto acsend

:acserror

echo Errors found in compiling ACS libraries. Aborting...
error.txt
exit

:acsend

REM Proceed to compile map scripts
cd ..\maps
del *.o
del error.txt

for %%v in (*.acs) do (
acc "%%v"
if exist acs.err ren acs.err error.txt
if exist error.txt goto mapscripterror
)

goto mapscriptnoerror

:mapscriptnoerror

echo Map scripts compiled successfully.
goto mapscriptend

:mapscripterror

echo Errors found in compiling map scripts. Aborting...
error.txt
exit

:mapscriptend

REM Use FBInserter to insert compiled objects into their respective WADs
for %%a in (*.wad) do fbinserter -nopause "%%a" "%%~na.o" MAP

REM Clean up any leftover junk
if exist *.bak del *.bak
if exist *.backup* del *.backup*
if exist *.o del *.o

:compileend