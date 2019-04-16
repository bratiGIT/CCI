@echo off
if exist "%AIADEV_HOME%" goto :execute_1
SET BATLOC=%~dp0
SET CURLOC=%CD%
CD %BATLOC%
if "%AIADEV_HOME%"=="" call ../etc/checkEnv.bat
CD %CURLOC%

:execute_1
if exist "%AUDIT_HOME%" goto :validateAIADEV

:defaultAudit
SET BATLOC=%~dp0
SET CURLOC=%CD%
CD %BATLOC%..
SET AUDIT_HOME=%CD%
CD %CURLOC%
SET PATH=%AUDIT_HOME%\bin;%PATH%
REM ECHO BATLOC=%BATLOC% -%AIADEV_HOME%\XSLDocGen\bin;
REM ECHO CURLOC=%CURLOC%
REM ECHO AUDIT=%AUDIT_HOME%

:validateAIADEV
if exist "%AIADEV_HOME%\lib" goto :validateJDK
goto :defaultCP

:validateJDK
if exist "%JAVA_HOME%\bin\java.exe" goto :startaudit
@echo %JAVA_HOME%\bin\java.exe does not exist!
@echo Set the JAVA_HOME variable to define the root of a JDK.
goto :end

:startaudit
if "%1"=="-version" goto :execute_2
if "%1"=="-help" goto :usage

:execute_2
SET OLD_CLASS_PATH=%CLASSPATH%
set CLASSPATH=%AUDIT_HOME%\config\;%AUDIT_HOME%\lib\;%AUDIT_HOME%\lib\compliance.policy.engine.jar;%CLASSPATH%;
set JAVA_COMMAND="%JAVA_HOME%\bin\java.exe" -Xms256m -Xmx1024m oracle.soa.aia.governance.auditor.tools.PIPAuditor %* 
REM Starting audit with command: %JAVA_COMMAND%
%JAVA_COMMAND%
SET CLASSPATH=%OLD_CLASS_PATH%
goto :end
:defaultJDK
   echo.
   echo -----------------------------------------------------------------------
   echo Usage:  
   echo        SET JAVA HOME BEFORE RUNNING CCI
   echo.
   echo Example:
   echo        SET JAVA_HOME=D:\JAVA1.5_10
   echo -----------------------------------------------------------------------
goto :end

:defaultCP
   echo.
   echo -----------------------------------------------------------------------
   echo Usage:  
   echo SET xmlunit-1.2.jar,xercesImpl.jar xmlparserv2.jar and compliance.policy.engine.jar Before running Code Compliance Inspector
   echo.
   echo Example:
   echo       SET CLASSPATH= ..\lib\xmlunit-1.2.jar;..\lib\xercesImpl.jar;..\lib\xmlparserv2.jar;..\lib\compliance.policy.engine.jar;%CLASSPATH%
   echo -----------------------------------------------------------------------
goto :end

:usage
   echo.
   echo -----------------------------------------------------------------------
   echo Syntax for execution :
   echo -------------------------------------------
   echo Usage:  
   echo %0 -inputDir {PROJECT_DIR} -outputDir {OUTPUT_DIR} -policy {POLICY_NAME} 
   echo. 
   echo --------------------
   echo Parameters :
   echo --------------------
   echo.
   echo  -inputDir         [REQUIRED] The directory which contains source code of the artifacts to be validated.
   echo  -outputDir        [REQUIRED] The directory where output files need to be generated.
   echo  -policiesFile	   [REQUIRED] Name of Policies xml file. If not provided default value will be taken from runtime.peroperties.
   echo  -assertionCatalog [REQUIRED] Name of Assertion catalog xml file. If not provided default value will be taken from runtime.peroperties.
   echo  -policy           [OPTIONAL] If not provided the default policy name will be taken from the Policies.xml.
   echo  -assertion        [OPTIONAL] Name of the Assertion to execute.
   echo  -inputMetaFile    [OPTIONAL] Path of the MetaFile which lists all the services used for the PIP. -inputMetaFile ALL would iterate through the inputDir and generate reports for all PIPS where MetaFile is found.
   echo   -version         [OPTIONAL] Displays the version of the tool.
   echo.
   echo --------------------            
   echo Example:
   echo --------------------
   echo %0 -inputDir D:\demo -outputDir D:\complianceResult -policy "AIA-Naming Standard"
   echo.  
   echo -----------------------------------------------------------------------
:end
