@echo off
SET BATLOC=%~dp0
SET old_pwd=%CD%
cd %BATLOC%
cd ..
SET AUDIT_HOME=%CD%
cd %old_pwd%
echo AUDIT_HOME=%AUDIT_HOME%
:checkJAVA_HOME
if not "%JAVA_HOME%"=="" goto :validateJDK
@echo Set the JAVA_HOME variable to define the root of a JDK.
goto :end

:validateJDK
if exist "%JAVA_HOME%\bin\java.exe" goto :startoercciSynch
@echo %JAVA_HOME%\bin\java.exe does not exist!
goto :end

:startoercciSynch
if "%1"=="-help" goto :usage
SET OLD_CLASS_PATH=%CLASSPATH%
SET OLD_PATH=%PATH%

SET CLASSPATH=%AUDIT_HOME%\lib\compliance.policy.engine.jar;%AUDIT_HOME%\config;%AUDIT_HOME%\lib;%AUDIT_HOME%\lib\axis.jar;%AUDIT_HOME%\lib\client.rex-11.1.1.6.0.jar;%AUDIT_HOME%\lib\commons-discovery-0.2.jar;%AUDIT_HOME%\lib\commons-logging-1.0.4.jar;%AUDIT_HOME%\lib\jaxrpc.jar;%AUDIT_HOME%\lib\wsdl4j-1.5.1.jar;%AUDIT_HOME%\lib\mail.jar;%AUDIT_HOME%\lib\activation.jar;%CLASSPATH%
SET PATH=%AUDIT_HOME%\bin;%PATH%

set JAVA_COMMAND="%JAVA_HOME%\bin\java.exe" -Xms256m -Xmx1024m oracle.soa.aia.governance.auditor.external.oer11g.ResultSynchService %* 
%JAVA_COMMAND%
SET CLASSPATH=%OLD_CLASS_PATH%
SET PATH=%OLD_PATH%
goto :end

rem :defaultCP
rem    echo.
rem    echo -----------------------------------------------------------------------
rem    echo Usage:  
rem    echo       SET xmlunit-1.2.jar,xercesImpl.jar xmlparserv2.jar and compliance.policy.engine.jar Before running audit Tool
rem    echo.
rem    echo Example:
rem    echo       SET CLASSPATH= ..\lib\xmlunit-1.2.jar;..\lib\xercesImpl.jar;..\lib\xmlparserv2.jar;..\lib\compliance.policy.engine.jar;%CLASSPATH%
rem    echo -----------------------------------------------------------------------
goto :end

:usage
   echo.
   echo -----------------------------------------------------------------------
   echo Syntax for invoking OER Synch is :
   echo -------------------------------------------
   echo Usage:  
   echo cci-oerSynch.bat -url {oer_service_url} -user {oer_user_name} -pwd {oer_pwd} -reportLocation {report_location}
   echo --------------------
   echo Parameters :
   echo --------------------
   echo   -url        		[OPTIONAL] Url to oer web_service server. If not specified value will come from property file.
   echo   -user       		[OPTIONAL] user name for connecting to oer. If not specified value will come from property file.
   echo   -pwd       		[OPTIONAL] password for connecting to oer. If not specified you will be prompt on runtime.
   echo   -reportLocation   [REQUIRED] location of outpur directory generated by Code Compliance Inspector.
   echo --------------------            
   echo Example:
   echo --------------------
   echo cci-oerSynch.bat -url http://example.domain.com:port/oer/services -user admin -reportLocation D:\Report\SOA\SyncProductBRMCommsReqABCSImpl
   echo -----------------------------------------------------------------------
:end
