#!/bin/bash 

 # SV-86849r5_rule - V-72225 - The Red Hat Enterprise Linux operating system must display the Standard Mandatory DoD Notice and Consent Banner immediately prior to, or as part of, remote access logon prompts. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

ssh_banner=$(sudo grep -i "you are accessing a u.s. government" $(sudo grep -i '^banner' /etc/ssh/sshd_config | awk '{print $2}'))

if test -z "$ssh_banner"
then
	result="Open"
	finding="SSH Banner is not set properly"
else
	result="NotAFinding"
fi

 echo "V-72225 - SV-86849r5_rule - $result - $finding"  
