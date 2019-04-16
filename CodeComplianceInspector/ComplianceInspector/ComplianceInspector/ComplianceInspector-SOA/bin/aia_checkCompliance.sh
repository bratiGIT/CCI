#!/bin/sh
############################################################################################
####Oracle Corporation                                                            		####
####Copyright (c) 2007, Oracle. All rights reserved                               		####
####This schell script executes CodeComplianceInspector to produce governance reports   ####
############################################################################################

source ./aia_setEnv.sh

RptDate=`date -u +%c`

echo Deleting output directory $OUTPUTDIR/CC
rm -rf $OUTPUTDIR/CC

echo Executing CodeComplianceInspector from $CHK_COMPLIANCE_BIN
echo CC Report generation started on `date`

echo Executing CodeComplianceInspector for $CORE_DIR_NAME
sh $CHK_COMPLIANCE_BIN -inputDir $COREDIR -outputDir $OUTPUTDIR/CC/CoreReports > checkCompliance_sh.log
mv -f $CHK_COMPLIANCE_HOME/bin/audit.log $OUTPUTDIR/CC/CoreReports/$CORE_DIR_NAME
mv -f checkCompliance_sh.log $OUTPUTDIR/CC/CoreReports/$CORE_DIR_NAME


echo Executing CodeComplianceInspector for Industry folder
for i in $INDUSTRYDIR/*;
do
echo `$i`
INDUSNAME=`basename $i`
if [ -d "$i" ]; then
sh $CHK_COMPLIANCE_BIN -inputDir $i -outputDir $OUTPUTDIR/CC/IndustryReports >checkCompliance_sh.log
mv -f $CHK_COMPLIANCE_HOME/bin/audit.log $OUTPUTDIR/CC/IndustryReports/$INDUSNAME
mv -f checkCompliance_sh.log $OUTPUTDIR/CC/IndustryReports/$INDUSNAME
fi
done

echo Executing CodeComplianceInspector for Core ALL PIP
if [ -z $1 ]; then
INPUTMETAFILE=$PIPNAME
else
INPUTMETAFILE=$1
fi
sh $CHK_COMPLIANCE_BIN -inputDir $INPUTDIR -inputMetaFile $INPUTMETAFILE -outputDir $OUTPUTDIR/CC > checkCompliance_sh.log

sed '1d' $REPORT_PRODUC_HOME/$REL/CC/AuditSummary.csv >> $OUTPUTDIR/CC/AuditSummary.csv
mv -f $CHK_COMPLIANCE_HOME/bin/audit.log $OUTPUTDIR/CC
mv -f checkCompliance_sh.log $OUTPUTDIR/CC

echo Completed CC Execution `date`

#######################################################################################

echo Creating compliance dashboard with timestamp $RptDate
sed -e "s/%TIMESTAMP%/$RptDate/" -e "s/%RELEASEVEHICLE%/$REL/g" -e "s/%COREDIRNAME%/$CORE_DIR_NAME/g" $CC_DB_PAGE > $OUTPUTDIR/compliance.html
cp $/AIA_CHK_COMPLIANCE_HOME/etc/Resources $OUTPUTDIR/../
#######################################################################################

echo Zipping up the generated compliance reports
cd $OUTPUTDIR
cd ..
zip -r "$REL"ComplianceReports.zip $REL Resources
mv "$REL"ComplianceReports.zip $REL

#######################################################################################

echo CC Report generation completed on `date`