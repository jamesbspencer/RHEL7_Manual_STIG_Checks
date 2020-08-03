#!/bin/bash 

 # SV-86615r6_rule - V-71991 - The Red Hat Enterprise Linux operating system must enable the SELinux targeted policy. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

running_policy=$(sudo sestatus | grep ^Loaded[[:space:]]policy[[:space:]]name | awk -F: '{print $2}' | sed  's/[ \t]*//g')
config_policy=$(sudo  grep -i "selinuxtype" /etc/selinux/config | grep -v '^#' | awk -F= '{print $2}')
if [[ ! "$running_policy" =~ targeted ]] && [[ ! "$config_policy" =~ targeted ]]; then
	result='Open'
	finding="$running_policy"
else
	result="NotAFinding"
fi

 echo "V-71991 - SV-86615r6_rule - $result - $finding"  
