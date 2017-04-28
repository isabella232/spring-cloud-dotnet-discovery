@ECHO OFF

:: Run unit tests 
cd test\Pivotal.Discovery.Client.Test
dotnet restore --configfile ..\..\nuget.config
dotnet test
if not "%errorlevel%"=="0" goto failure
cd ..\..

echo Unit Tests Pass
goto success
:failure
echo Unit Tests Failure
exit -1
:success