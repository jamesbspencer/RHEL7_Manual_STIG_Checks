#!/bin/bash 

 # SV-86567r6_rule - V-71943 - The Red Hat Enterprise Linux operating system must be configured to lock accounts for a minimum of 15 minutes after three unsuccessful logon attempts within a 15-minute timeframe. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

OIFS=$IFS
IFS=$'\n'
for i in $(sudo grep -h pam_faillock.so /etc/pam.d/password-auth /etc/pam.d/system-auth | grep '^#*auth')
do
	echo "$i"
	commented=$(echo "$i" | grep '^#')
	deny=$(echo "$i" | grep -o 'deny=[0-9]*' | awk -F= '{print $2}') 
	deny_root=$(echo "$i" | grep "even_deny_root")
	interval=$(echo "$i" | grep -o 'fail_interval=[0-9]*' | awk -F= '{print $2}')
	unlock=$(echo "$i" | grep -o 'unlock_time=[0-9]*' | awk -F= '{print $2}')
if test -z "$commented" && [[ "$deny" -ge "3" && "$deny" -ne "0" ]] && test -n "$deny_root" && [ "$interval" -ge "900" ] && [[ "$unlock" != "never" || "$unlock" -ge "900" ]]
then
	result="NotAFinding"
	
else
	result="Open"
	finding="pam_faillock.so is not configured properly"	
	break
fi
done
IFS=$OIFS

 echo "V-71943 - SV-86567r6_rule - $result - $finding"  
