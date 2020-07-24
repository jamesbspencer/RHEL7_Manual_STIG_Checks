#!/bin/bash 

# V-72037 - SV-86661r2_rule - The Red Hat Enterprise Linux operating system must be configured so that local initialization files do not execute world-writable programs. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

wwp=$(sudo find / -xdev -perm -002 -type f)
if [ ! -z "$wwp" ]; then
	result='Open'
	finding="World-writable init files found"
else
	result="NotAFinding"
fi

echo "V-72037 - SV-86661r2_rule - $result - $finding"
