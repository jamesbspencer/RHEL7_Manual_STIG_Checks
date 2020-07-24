#!/bin/bash 

# V-72043 - SV-86667r2_rule - The Red Hat Enterprise Linux operating system must prevent files with the setuid and setgid bit set from being executed on file systems that are used with removable media. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

parts=$(sudo grep -v ^#  /etc/fstab | grep -v mapper | grep -i /dev)
if ! [[ "$parts" =~ nosuid ]]; then
	result='Open'
	finding="$parts"
else
	result="NotAFinding"
fi

echo "V-72043 - SV-86667r2_rule - $result"
