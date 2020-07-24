#!/bin/bash 

# V-72209 - SV-86833r2_rule - The Red Hat Enterprise Linux operating system must send rsyslog output to a log aggregation server. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

send=`sudo grep -h -v ^# /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep @  | grep '^\*\.\*'`
if [ -z "$send" ]; then
	result='Open'
	finding="rsyslog not forwarding"
else
	result="NotAFinding"
fi

echo "V-72209 - SV-86833r2_rule - $result - $finding"  
