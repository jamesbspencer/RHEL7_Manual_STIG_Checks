#!/bin/bash 

 # SV-95725r3_rule - V-81013 - The Red Hat Enterprise Linux operating system must mount /dev/shm with secure options. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

temp_dir=$(sudo grep -v '^#' /etc/fstab | grep /dev/shm | grep nodev | grep nosuid | grep noexec)
if test -z "$temp_dir"
then
	result="Open"
	finding="temp partition not configured correctly"
else
	result="NotAFinding"
fi

 echo "V-81013 - SV-95725r3_rule - $result - $finding"  
