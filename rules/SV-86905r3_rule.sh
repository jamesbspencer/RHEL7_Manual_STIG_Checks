#!/bin/bash 

# V-72281 - SV-86905r3_rule - For Red Hat Enterprise Linux operating systems using DNS resolution, at least two name servers must be configured. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

ns_dns=$(sudo grep '^hosts' /etc/nsswitch.conf | grep dns)

if test -z "$ns_dns" && test -s "/etc/resolv.conf"
then
	result="Open"
	finding="DNS is not in nsswitch.conf and resolve.conf is not empty"
else
	dns_count=$(sudo grep -i "^nameserver" /etc/resolv.conf | wc -l)
	if [ "$dns_count" -lt 2 ]
	then
		result="Open"
		finding="resolv.conf must have at least 2 entries"
	else
		result="NotAFinding"
	fi
fi
	
echo "V-72281 - SV-86905r3_rule - $result - $finding"  
