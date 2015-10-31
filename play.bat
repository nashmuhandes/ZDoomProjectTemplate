call compile.bat

:compileend

cd /d %exepath%
%exename% -noautoload -file %projectpath%\%sourcedirname%

exit