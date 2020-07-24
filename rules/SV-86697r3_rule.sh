#!/bin/bash 

# V-72073 - SV-86697r3_rule - The Red Hat Enterprise Linux operating system must use a file integrity tool that is configured to use FIPS 140-2 approved cryptographic hashes for validating file contents and directories. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

aide=$(sudo rpm -qa | grep "aide")
if [ -z "$aide" ]
then
	result='Open'
	finding="AIDE is not installed"
	
else
	aide_conf=$(sudo find / -name "aide.conf")
	if [ -z "$aide_conf" ]
	then
		result="Open"
		finding="aide config not found"
		
	else
		acl=$(sudo grep -i ^ALL[[:space:]=][[:space:]=]* $aide_conf | grep sha512)
		if [ -z "$acl" ]
		then
			result="Open"
			finding="ACL not found in aide config file"
		else
			result="NotAFinding"
		fi
	fi

fi

echo "V-72073 - SV-86697r3_rule - $result - $finding"  