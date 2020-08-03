#!/bin/bash 

 # SV-86847r5_rule - V-72223 - The Red Hat Enterprise Linux operating system must be configured so that all network connections associated with a communication session are terminated at the end of the session or after 15 minutes of inactivity from the user at a command prompt, except to fulfill documented and validated mission requirements. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

timeout=$(sudo grep -h -i '^tmout' /etc/profile.d/* | awk -F= '{print $2}')
if [ "$timeout" -gt "900" ]
then
	result="Open"
	finding="TMOUT is set to $timeout"
else
	result="NotAFinding"
fi

 echo "V-72223 - SV-86847r5_rule - $result - $finding"  
