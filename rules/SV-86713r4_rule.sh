#!/bin/bash 

# V-72089 - SV-86713r4_rule - The Red Hat Enterprise Linux operating system must initiate an action to notify the System Administrator (SA) and Information System Security Officer ISSO, at a minimum, when allocated audit record storage volume reaches 75% of the repository maximum audit record storage capacity. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

audit_log=$(sudo grep -iw log_file /etc/audit/auditd.conf | awk -F= '{print $2}')
part=$(sudo df $audit_log | awk '/^\/dev/ {print}')
part_path=$(echo $part | awk '{print $6}')
part_size=$(echo $part | awk '{print $2}')
if [[ "$part_path" =~ "audit" ]]; then
	space=$(sudo grep -iw space_left /etc/audit/auditd.conf | awk -F= '{print $2}')
	left=$(echo $space $part_size | awk '{print (($1 * 1024) / $2) * 100}')
	perc=$(echo $left | awk '{if($left < 25){print "a"}else{print "b"}}')
	if [ "$perc" = "a" ]
	then
		result="Open"
		finding="$left %"
	else
		result="NotAFinding"
	fi
else
	result='Open'
fi

echo "V-72089 - SV-86713r4_rule - $result - $finding"  
