#!/bin/bash 

# V-72007 - SV-86631r3_rule - The Red Hat Enterprise Linux operating system must be configured so that all files and directories have a valid owner. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

no_user=$(sudo find / -fstype xfs -nouser 2>/dev/null)
if [ -n "$no_user" ]; then
	result='Open'
	finding="There are files that have no owner"
else
	result="NotAFinding"
fi

echo "V-72007 - SV-86631r3_rule - $result - $finding"  
