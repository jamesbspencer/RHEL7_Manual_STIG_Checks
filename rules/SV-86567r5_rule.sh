#!/bin/bash 

 # V-71943 - SV-86567r5_rule - The Red Hat Enterprise Linux operating system must be configured to lock accounts for a minimum of 15 minutes after three unsuccessful logon attempts within a 15-minute timeframe. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 
 
OIFS=$IFS
IFS=$'\n'
for i in $(sudo grep pam_faillock.so /etc/pam.d/password-auth | grep '^auth')
do
	if [[ "$i" =~ "deny=3" ]]
	then
		result="NotAFinding"
	else
		result="Open"
		finding="$i"
		break
	fi
done
IFS=$OIFS

echo "V-71943 - SV-86567r5_rule - $result - $finding" 
