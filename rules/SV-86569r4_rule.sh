#!/bin/bash 

# V-71945 - SV-86569r4_rule - The Red Hat Enterprise Linux operating system must lock the associated account after three unsuccessful root logon attempts are made within a 15-minute period. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

OIFS=$IFS
IFS=$'\n'
for i in $(sudo grep pam_faillock.so /etc/pam.d/password-auth | grep '^auth')
do
	if [[ "$i" =~ "even_deny_root" ]]
	then
		result="NotAFinding"
	else
		result="Open"
		finding="$i"
		break
	fi
done
IFS=$OIFS

echo "V-71945 - SV-86569r4_rule - $result - $finding"  
