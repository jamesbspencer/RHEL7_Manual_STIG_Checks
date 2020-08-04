#!/bin/bash 

# V-72269 - SV-86893r5_rule - The Red Hat Enterprise Linux operating system must, for networked systems, synchronize clocks with a server that is synchronized to one of the redundant United States Naval Observatory (USNO) time servers, a time server designated for the appropriate DoD network (NIPRNet/SIPRNet), and/or the Global Positioning System (GPS). # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

active=$(sudo systemctl show ntpd --property=ActiveState | awk -F= '{print $2}')
if [ "$active" =  "active" ]; then
	max_poll=$(sudo grep -v ^# /etc/ntp.conf | grep -o 'maxpoll[[:space:]]*[0-9]*' | uniq | awk '{print $2}')
	if test -z "$max_poll"
	then
		result='Open'
		finding="Max Poll is not set"
	elif [ "$max_pool" -ge "17" ]
	then
		result="Open"
		finding"Max Poll is set too high"
	else
		result="NotAFinding"
	fi
else
	result='Open'
	finding="NTPD is not running"
fi

echo "V-72269 - SV-86893r5_rule - $result - $finding"  
