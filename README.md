# AutoSegVal (Working but still in progress)
## Problem ##
When conducting PCI segmentation validation, you must run port scans against each individual CDE network from each Business network. This is a time consuming process that requires the auditor to monitor nMap scans for hours at a time. This script was built to minimize the amount of wasted time that comes with doing PCI segmentation validation.

## Installation ##
- mkdir AutoSegVal
- Clone the repository to /AutoSegVal
- Install dependencies. It is likely that python3 and xsltproc are already installed in Kali. ssmtp will need to be installed.
  - python3
  - ssmtp
  - xsltproc

## Configure SSMTP ##
One of the best things about this script is it's ability to send you an email when the all CDE networks have been scanned from the current Business network. This requires a simple configuration change to ssmtp. You will need to create a gmail account for this and turn on "Allow Unsecure Apps". Co-Workers, please contact me for our working credentials.

UseSTARTTLS=YES<br>
FromLineOverride=YES<br>
root=EMAIL GOES HERE<br>
mailhub=smtp.gmail.com:587<br>
AuthUser=EMAIL GOES HERE<br>
AuthPass=PASSWORD GOES HERE<br>

## Usage ##
The script accepts a .csv file as the only command line argument. This .csv will contain the list of CDE networks that need to be scanned. It should be formatted as such. BUSINESSVLAN,RANGE,UNIQUEID. DO NOT INCLUDE HEADERS!! A sample .csv has been included in the repo. Please use the following format.

VLAN12,192.168.1.1/24,1<br>
VLAN45,192.168.56.1/24,2<br>
VLAN01,192.168.100.1/24,3

Once the script is executed, you will be asked a couple of questions that effect the nMap scans and the file structure. After that, it is a waiting game.

## Output ##
Output is generated in multiple ways. A folder will be created for the Business VLAN you are scanning from. Here you will find the following.

- XML files for each individual CDE network scanned.
- An XML file that contains the combined output of all CDE networks scanned.
- An HTML file generated by xsltproc that beautifies the output.

PLEASE LET ME KNOW IF YOU HAVE ANY SUGGESTIONS OR FIND ANY BUGS!!

