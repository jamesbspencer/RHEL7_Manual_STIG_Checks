#!/bin/bash 

# V-72227 - SV-86851r4_rule - The Red Hat Enterprise Linux operating system must implement cryptography to protect the integrity of Lightweight Directory Access Protocol (LDAP) authentication communications. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

test_sssd=$(sudo rpm -qa | grep -i sssd)
if test -z "$test_sssd"
then
	result="Not_Applicable"
	finding="LDAP is not being used"
else
	sssd_service=$(sudo sysemctl show sssd --property=SubState | awk -F= '{print $2}')
	if [ "$sssd_service" != "running" ]
	then
		result="Not_Applicable"
		finding="LDAP is not being used"
	else
		provider=$(sudo grep -i "id_provider" /etc/sssd/sssd.conf | awk -F= '{print $2}' | xargs)
		if [ "$provider" = "ad" ]
		then
			result="Not_Applicable"
			finding="LDAP is not being used"
		else
			tls=$(sudo grep -i "^start_tls" /etc/sssd/sssd.conf | awk -F= '{print $2}' | grep -i true)
			if test -z "$tls"
			then
				result="Open"
				finding="TLS is not enabled"
			else
				result="NotAFinding"
			fi
		fi
	fi
fi

echo "V-72227 - SV-86851r4_rule - $result - $finding"  
