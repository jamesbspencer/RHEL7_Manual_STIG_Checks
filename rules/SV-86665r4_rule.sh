#!/bin/bash 

# V-72041 - SV-86665r4_rule - The Red Hat Enterprise Linux operating system must be configured so that file systems containing user home directories are mounted to prevent files with the setuid and setgid bit set from being executed. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

home_dir=$(sudo awk -F= '$1 ~ "^HOME" {print $2}' /etc/default/useradd)
no_suid=$(sudo grep -i $home_dir /etc/fstab | grep  nosuid)
if [ -z "$no_suid" ]; then
	result='Open'
	finding="$no_suid"
else
	result="NotAFinding"
fi

echo "V-72041 - SV-86665r4_rule - $result - $finding"  
