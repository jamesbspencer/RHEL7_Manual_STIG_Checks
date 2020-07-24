#!/bin/bash 

# V-92251 - SV-102353r1_rule - The Red Hat Enterprise Linux operating system must use a reverse-path filter for IPv4 network traffic when possible on all interfaces. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

rp_filter=$(sudo grep -h -v ^# /etc/sysctl.conf /etc/sysctl.d/* | grep net.ipv4.conf.all.rp_filter | uniq | awk -F= '{print $2}')
if [ -z "$rp_filter" ]; then
	result='Open'
	finding="Reverse path filter not found"
else
	if [ "$rp_filter" -ne "1" ]
	then
		result="Open"
		finding="Reverse path filter not enabled"
	else
		result="NotAFinding"
	fi
fi

echo "V-92251 - SV-102353r1_rule - $result - $finding"  
