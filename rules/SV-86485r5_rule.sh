#!/bin/bash 

 # SV-86485r5_rule - V-71861 - The Red Hat Enterprise Linux operating system must display the approved Standard Mandatory DoD Notice and Consent Banner before granting local or remote access to the system via a graphical user logon. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

banner=$(sudo grep -s -h banner-message-text /etc/dconf/db/local.d/* | awk -F= '{print $2}' | grep -i "you are accessing a u.s. government")
if test -z "$banner"
then
	result="Open"
	finding="No the correct banner"
else
	result="NotAFinding"
fi

 echo "V-71861 - SV-86485r5_rule - $result - $finding"  
