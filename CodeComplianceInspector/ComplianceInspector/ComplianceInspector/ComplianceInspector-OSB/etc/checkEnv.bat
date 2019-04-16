@echo off
TITLE Oracle AIA Developer Console 
if "%AIADEV_HOME%"=="" goto :defaultDEV
goto :end

:defaultDEV
SET BATLOC1=%~dp0
SET CURLOC1=%CD%
CD %BATLOC1%..
SET AIADEV_HOME=%CD%
CD %CURLOC1%
REM SET JAVA_HOME_BAK=%JAVA_HOME%
REM if not exist "%AIA_HOME%" CALL %AIADEV_HOME%\bin\setenv.bat
REM if "%JAVA_HOME%"=="" SET JAVA_HOME=%JAVA_HOME_BAK%
if exist "%AIA_HOME%\bin\aiaenv.bat" goto :call_aiaenv

if "%JAVA_HOME%"=="" goto :defaultJDK
:validateJDK
echo Validating JDK
if exist "%JAVA_HOME%\bin\java.exe" goto :setCP
echo %JAVA_HOME%\bin\java.exe does not exist!
SET AIADEV_HOME=
goto :end
:setCP
echo Please make sure all dependent libraries are present in ComplianceInspector/lib. See installation instructions.
SET CLASSPATH=%AIADEV_HOME%\lib\xmlunit-1.2.jar;%AIADEV_HOME%\lib\xercesImpl.jar;%AIADEV_HOME%\lib\xmlparserv2.jar;%AIADEV_HOME%\lib\orai18n-collation.jar;%AIADEV_HOME%\lib\orai18n-mapping.jar;.;%AIADEV_HOME%\lib\axis.jar;%AIADEV_HOME%\lib\client.rex-11.1.1.6.0.jar;%AIADEV_HOME%\lib\commons-discovery-0.2.jar;%AIADEV_HOME%\lib\commons-logging-1.0.4.jar;%AIADEV_HOME%\lib\jaxrpc.jar;%AIADEV_HOME%\lib\wsdl4j-1.5.1.jar;%AIADEV_HOME%\lib\mail.jar;%AIADEV_HOME%\lib\activation.jar;%CLASSPATH%
goto :end

:call_aiaenv
CALL %AIA_HOME%\bin\aiaenv.bat
:setFPCP
echo AIA_HOME found. Please make sure xmlunit-1.2.jar is present in ComplianceInspector/lib.
SET CLASSPATH=%AIADEV_HOME%\lib\xmlunit-1.2.jar;.;%ANT_HOME%\lib\xercesImpl.jar;%ORACLE_HOME%\lib\xmlparserv2.jar;%AIADEV_HOME%\lib\orai18n-collation.jar;%AIADEV_HOME%\lib\orai18n-mapping.jar;%AIADEV_HOME%\lib\axis.jar;%AIADEV_HOME%\lib\client.rex-11.1.1.6.0.jar;%AIADEV_HOME%\lib\commons-discovery-0.2.jar;%AIADEV_HOME%\lib\commons-logging-1.0.4.jar;%AIADEV_HOME%\lib\jaxrpc.jar;%AIADEV_HOME%\lib\wsdl4j-1.5.1.jar;%AIADEV_HOME%\lib\mail.jar;%AIADEV_HOME%\lib\activation.jar;%CLASSPATH%
goto :end


:defaultJDK
REM CALL %AIADEV_HOME%\bin\setenv.bat
if NOT "%JAVA_HOME%"=="" goto :validateJDK
   echo.
   echo -----------------------------------------------------------------------
   echo Install step:  
   echo        SET JAVA HOME BEFORE RUNNING CCI
   echo.
   echo Example:
   echo        SET JAVA_HOME=D:\JAVA1.5_10
   echo -----------------------------------------------------------------------
SET AIADEV_HOME=
:end
echo -----------------------------------------------------------------------
ECHO DEVHOME=%AIADEV_HOME%
echo -----------------------------------------------------------------------
ECHO PATH=%PATH%
echo -----------------------------------------------------------------------
ECHO CLASSPATH=%CLASSPATH%
echo -----------------------------------------------------------------------
