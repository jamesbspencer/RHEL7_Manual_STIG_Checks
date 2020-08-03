#!/bin/bash 

 # SV-86595r4_rule - V-71971 - The Red Hat Enterprise Linux operating system must prevent non-privileged users from executing privileged functions to include disabling, circumventing, or altering implemented security safeguards/countermeasures. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

min=$(sudo grep '^UID_MIN' /etc/login.defs | awk '{print $2}')
max=$(sudo grep '^UID_MAX' /etc/login.defs | awk '{print $2}')

for u in $(sudo awk -v min=$min -v max=$max -F: '($3 > min) && ($3 < max) {print $1}' /etc/passwd)
do
	se_user=`sudo semanage login -l | grep $u | awk '{print $2}' `
	if [ -z "$se_user" ]
	then
		result="Open"
		finding="$u"
		break
	elif [ "$se_user" != "staff_u" ] &&  [ "$se_user" != "sysadm_u" ]
	then
		result="Open"
		finding="$u $se_user"
		break
	else
		result="NotAFinding"
	fi
done

 echo "V-71971 - SV-86595r4_rule - $result - $finding"  
