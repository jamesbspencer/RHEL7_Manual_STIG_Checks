#!/bin/bash 

# V-72017 - SV-86641r3_rule - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user home directories have mode 0750 or less permissive. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

for dir in $(sudo egrep ':[0-9]{4}' /etc/passwd | cut -d: -f6)
do
	perms=$(sudo stat -c %a $dir)
	if [ "$perms" -gt "750" ]; then
		finding=$(echo "$dir" | awk -F/ '{print $NF}')
		result='Open'
		break
	else
		result="NotAFinding"
	fi
done

echo "V-72017 - SV-86641r3_rule - $result - $finding"
