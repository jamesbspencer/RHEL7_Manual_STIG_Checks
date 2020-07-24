#!/bin/bash 

# V-81009 - SV-95721r2_rule - The Red Hat Enterprise Linux operating system must mount /dev/shm with the nodev option. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

temp_dir=$(sudo grep -v ^# /etc/fstab | grep -i /dev/shm)
if ! [[ "$temp_dir" =~ "nodev" ]]; then
	result='Open'
	finding="NODEV not found in temp drive"
else
	result="NotAFinding"
fi

echo "V-81009 - SV-95721r2_rule - $result - $finding" 
