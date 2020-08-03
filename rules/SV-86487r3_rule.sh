#!/bin/bash 

 # SV-86487r3_rule - V-71863 - The Red Hat Enterprise Linux operating system must display the Standard Mandatory DoD Notice and Consent Banner before granting local or remote access to the system via a command line user logon. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

banner=$(sudo more /etc/issue | grep -i "you are accessing a u.s. government")
if test -z "$banner"
then
	result="Open"
	finding="Not the correct banner"
else
	result="NotAFinding"
fi

 echo "V-71863 - SV-86487r3_rule - $result - $finding"  
