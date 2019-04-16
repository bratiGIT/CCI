#!/bin/sh
old_pwd=`pwd`
cd `dirname $0`
#echo "directory where shell script is located :`pwd`"
#cd ..
AUDIT_HOME=`pwd`
export AUDIT_HOME
cd ..
#echo calling checkEnv.sh with dir `pwd`
source `pwd`/etc/checkEnv.sh
cd $old_pwd
CLASSPATH=$AIADEV_HOME/config:$AIADEV_HOME/lib:$AIADEV_HOME/lib/compliance.policy.engine.jar:$CLASSPATH
PATH=$AIADEV_HOME/bin:$PATH
#echo $CLASSPATH
#echo $PATH
if [ "$1" = "-help" ]
then 
   echo -----------------------------------------------------------------------
   echo Syntax for execution :
   echo -------------------------------------------
   echo Usage:  
   echo ./checkCompliance.sh -inputDir {PROJECT_DIR} -outputDir {OUTPUT_DIR} -policy {POLICY_NAME} 
   echo --------------------
   echo Parameters :
   echo --------------------
   echo -inputDir        [REQUIRED] The directory which contains source code of the artifacts to be validated.
   echo -outputDir       [REQUIRED] The directory where output files need to be generated.
   echo -policiesFile	 [REQUIRED] Name of Policies xml file. If not provided default value will be taken from runtime.peroperties.
   echo -assertionCatalog[REQUIRED] Name of Assertion catalog xml file. If not provided default value will be taken from runtime.peroperties.
   echo -policy          [OPTIONAL] If not provided the default policy name will be taken from the Policies.xml.
   echo -assertion       [OPTIONAL] Name of the assertion to execute.
   echo -inputMetaFile   [OPTIONAL] Path of the MetaFile which lists all the services used for the PIP. -inputMetaFile ALL would iterate through the inputDir and generate reports for all PIPS where MetaFile is found.
   echo   -version       [OPTIONAL] Displays the version of the tool.
   echo --------------------            
   echo Example:
   echo --------------------
   echo ./checkCompliance.sh -inputDir /home/demo -outputDir /home/complianceResult -policy "AIA-Naming Standard"
   echo -----------------------------------------------------------------------
exit 1
fi
echo "------------------------------------------------------------------------"
echo CCI CP : $CLASSPATH
echo "------------------------------------------------------------------------"
export CLASSPATH
$JAVA_HOME/bin/java -Xms256m -Xmx1024m oracle.soa.aia.governance.auditor.tools.PIPAuditor "$@"
