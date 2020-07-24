#!/bin/bash 

# V-72229 - SV-86853r4_rule - The Red Hat Enterprise Linux operating system must implement cryptography to protect the integrity of Lightweight Directory Access Protocol (LDAP) communications. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
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
			tls=$(sudo grep -i "^ldap_tls_reqcert" /etc/sssd/sssd.conf | awk -F= '{print $2}' | grep -i -E "(demand|hard)")
			if test -z "$tls"
			then
				result="Open"
				finding="TLS is not being required"
			else
				result="NotAFinding"
			fi
		fi
	fi
fi

echo "V-72229 - SV-86853r4_rule - $result - $finding"  
