#!/bin/bash 

# V-72223 - SV-86847r4_rule - The Red Hat Enterprise Linux operating system must be configured so that all network connections associated with a communication session are terminated at the end of the session or after 10 minutes of inactivity from the user at a command prompt, except to fulfill documented and validated mission requirements. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

timeout=$(sudo grep -h -i ^tmout /etc/profile.d/*)
if [ -n "$timeout" ]; then
	value=$(echo $timeout | awk -F= '{print $2}')
	if [ "$value" -lt "600" ]; then
		result="Open"
		finding="$value"
	else
		result="NotAFinding"
	fi
else
	result='Open'
	finding="Timeout value not found"
fi

echo "V-72223 - SV-86847r4_rule - $result"  
