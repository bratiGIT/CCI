#!/bin/sh
export AIADEV_HOME=`pwd`
echo $JAVA_HOME
JAVA_HOME_BAK=$JAVA_HOME

echo Please make sure all dependent libraries are present in ComplianceInspector/lib. See installation instructions.
CLASSPATH=$AIADEV_HOME/lib/xmlunit-1.2.jar:$AIADEV_HOME/lib/xercesImpl.jar:$AIADEV_HOME/lib/xmlparserv2.jar:$AIADEV_HOME/lib/orai18n-collation.jar:$AIADEV_HOME/lib/orai18n-mapping.jar:$AIADEV_HOME/lib/axis.jar:$AIADEV_HOME/lib/client.rex-11.1.1.6.0.jar:$AIADEV_HOME/lib/commons-discovery-0.2.jar:$AIADEV_HOME/lib/commons-logging-1.0.4.jar:$AIADEV_HOME/lib/jaxrpc.jar:$AIADEV_HOME/lib/wsdl4j-1.5.1.jar:$AIADEV_HOME/lib/mail.jar:$AIADEV_HOME/lib/activation.jar:$CLASSPATH

if [ "$JAVA_HOME" = "" ] 
then
echo Setting JAVA_HOME to $JAVA_HOME_BAK
if [ "$JAVA_BAK_HOME" = "" ] 
then
   echo -----------------------------------------------------------------------
   echo JAVA_HOME environment variable is required to be set before running CCI.
   echo Usage:  
   echo        export JAVA_HOME
   echo Example:
   echo        setenv JAVA_HOME /home/JAVA1.5_10
   echo -----------------------------------------------------------------------

exit 1
else
echo Setting JAVA_HOME to $JAVA_HOME_BAK
JAVA_HOME=$JAVA_HOME_BAK
fi
fi
echo "------------------------------------------------------------------------"
echo ORACLE HOME : $ORACLE_HOME
echo "------------------------------------------------------------------------"
echo ANT HOME : $ANT_HOME
echo "------------------------------------------------------------------------"
echo JAVA HOME : $JAVA_HOME
echo "------------------------------------------------------------------------"
echo AIA HOME : $AIA_HOME
echo "------------------------------------------------------------------------"
echo CP : $CLASSPATH
echo "------------------------------------------------------------------------"
if [ -f "$JAVA_HOME/bin/java" ]
then
echo JRE selected is : $JAVA_HOME/bin/java 
else
echo $JAVA_HOME/bin/java does not exist!
exit 1	
fi
