#! /bin/bash

# A single argument will be the csv file name.
INPUT="$1"

# Taking in input on how the nMap scans should be performed.
echo Which VLAN is the field system on?
read SCANNINGVLAN
echo What is your email address?
read EMAIL
echo How many ports should I scan? --top-ports ex. 2000
read TOPPORTS
echo How many times should I retry an unresponsive port? --max-retries ex. 1
read MAXRETRIES
echo How long should I wait for a response? --max-rtt-timeout ex. 200
read MAXRTTTIMEOUT
echo Scanning networks in $INPUT from $SCANNINGVLAN
sleep 3

# Runs the scans and outputs them as xml files.
OLDIFS=$IFS
IFS=','
while read RANGE VLAN ID
do
	echo Currently scanning $VLAN
	mkdir -p ./ScanningFrom$SCANNINGVLAN
	nmap -v -d -d --max-retries $MAXRETRIES --max-rtt-timeout ${MAXRTTTIMEOUT}ms -T4 -Pn --top-ports $TOPPORTS -oX ./ScanningFrom$SCANNINGVLAN/$VLAN.xml $RANGE
	#sed -i '1,4d' ./ScanningFrom$SCANNINGVLAN/$VLAN
	sleep 5
done < $INPUT

# Python module that combines the xml files and uses xsltproc to output as pretty HTML.
python3 nMapMerge.py -d ./ScanningFrom$SCANNINGVLAN
mv *.xml ./ScanningFrom$SCANNINGVLAN
mv *.html ./ScanningFrom$SCANNINGVLAN

echo "Your segmentation validation scan from $SCANNINGVLAN is complete" | ssmtp $EMAIL

echo Results are located at ./ScanningFrom$SCANNINGVLAN
IFS=$OLDIFS