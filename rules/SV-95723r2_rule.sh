#!/bin/bash 

# V-81011 - SV-95723r2_rule - The Red Hat Enterprise Linux operating system must mount /dev/shm with the nosuid option. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

temp_dir=`sudo grep -v ^# /etc/fstab | grep -i /dev/shm`
if ! [[ "$temp_dir" =~ "nosuid" ]]; then
	result='Open'
	finding="NOSUID not found on temp partition"
else
	result="NotAFinding"
fi

echo "V-81011 - SV-95723r2_rule - $result - $finding"  
