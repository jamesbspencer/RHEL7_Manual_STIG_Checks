#!/bin/bash 

# V-72009 - SV-86633r3_rule - The Red Hat Enterprise Linux operating system must be configured so that all files and directories have a valid group owner. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

no_group=$(sudo find / -fstype xfs -nogroup 2>/dev/null)
if [ -n "$no_group" ]; then
	result='Open'
	finding="There are files with no group owner"
else
	result="NotAFinding"
fi

echo "V-72009 - SV-86633r3_rule - $result - $finding"  
