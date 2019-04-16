#!/bin/sh
echo Setting up the environment variables for CodeComplianceInspector scripts. 
####### BELOW ENVIRONMENT USER NEED TO UPDATE ##################
export VERSION=11.x
if [ -z $1 ]; then
	echo from shript file.
	export INPUTDIR=$HOME/fdrive/AIASource/AIA3.1/apps
	export REPORT_STAGING_HOME=$HOME/fdrive/AIAReports
	export REPORT_PRODUC_HOME=$HOME/fdrive/AIAReports
	export AIA_CHK_COMPLIANCE_HOME=$AIADEV_HOME/CodeComplianceInspector
else
	echo from command linew file.
	export INPUTDIR=$1;
	export REPORT_STAGING_HOME=$2;
	export REPORT_PRODUC_HOME=$3;
	export AIA_CHK_COMPLIANCE_HOME=$4;
fi
echo $INPUTDIR , $REPORT_STAGING_HOME, $AIA_CHK_COMPLIANCE_HOME

export PIPNAME=ALL #USER CAN SPECIFY INPUTMETAFILE, IF WANTS TO RUN FOR SINGLE PIP.
####### BELOW ENVIRONMENT AUTOMATICALLY DERIVED ##################
export REL=RV$VERSION
export OUTPUTDIR=$REPORT_STAGING_HOME/$REL
export CHK_COMPLIANCE_HOME=$AIA_CHK_COMPLIANCE_HOME
export CHK_COMPLIANCE_BIN=$AIA_CHK_COMPLIANCE_HOME/bin/checkCompliance.sh
####### BELOW ENVIRONMENT AUTOMATICALLY DERIVED BASED ON VERSION ##################
if [ $VERSION == "2.5" ] || [ $VERSION == "2.x" ]; then
	export AIAMETADATADIR=$INPUTDIR
	export COREDIR=$INPUTDIR/PIPS/Core
	export INDUSTRYDIR=$INPUTDIR/PIPS/Industry
elif [ $VERSION == "11.2" ] || [ $VERSION == "11.x" ]; then 
	export AIAMETADATADIR=$INPUTDIR/fp/components/AIAMetaData
	export COREDIR=$INPUTDIR/services/core
	export INDUSTRYDIR=$INPUTDIR/services/industry
fi
export CORE_DIR_NAME=${COREDIR##*/}
## THE BELOW ENVIRONMENT VARIABLES USED TO ASSIGN PATH OF TEMPLATE DASHBOARD PAGES##
export CC_DB_PAGE=$CHK_COMPLIANCE_HOME/etc/ComplianceReports.html
echo Environment variables setup completed.