#!/bin/bash 

# V-81013 - SV-95725r2_rule - The Red Hat Enterprise Linux operating system must mount /dev/shm with the noexec option. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

temp_dir=$(sudo grep -v ^# /etc/fstab | grep -i /dev/shm)
if ! [[ "$temp_dir" =~ "noexec" ]]; then
	result='Open'
	finding="NOEXEC not found on temp partition"
else
	result="NotAFinding"
fi

echo "V-81013 - SV-95725r2_rule - $result - $finding"  
