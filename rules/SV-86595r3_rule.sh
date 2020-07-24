#!/bin/bash 

# V-71971 - SV-86595r3_rule - The Red Hat Enterprise Linux operating system must prevent non-privileged users from executing privileged functions to include disabling, circumventing, or altering implemented security safeguards/countermeasures. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

for u in $(sudo cat /etc/passwd | awk -F: '($3 > 1001) && ($3 < 10000){print $1}')
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

echo "V-71971 - SV-86595r3_rule - $result - $finding"  
