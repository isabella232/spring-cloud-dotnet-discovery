:: @ECHO OFF

:: Build packages
cd %APPVEYOR_BUILD_FOLDER%
cd src\Pivotal.Discovery.Client
dotnet restore --configfile ..\..\nuget.config
IF NOT "%APPVEYOR_REPO_TAG_NAME%"=="" (dotnet pack --configuration %BUILD_TYPE%)
IF "%APPVEYOR_REPO_TAG_NAME%"=="" (dotnet pack --configuration %BUILD_TYPE% --version-suffix %STEELTOE_VERSION_SUFFIX% --include-symbols --include-source)
cd %APPVEYOR_BUILD_FOLDER%
