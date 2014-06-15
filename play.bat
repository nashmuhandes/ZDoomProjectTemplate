call compile.bat

:compileend

cd %exepath%
%exename% -noautoload -file %projectpath%\%sourcedirname%

exit