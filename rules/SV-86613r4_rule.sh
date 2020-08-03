#!/bin/bash 

 # SV-86613r4_rule - V-71989 - The Red Hat Enterprise Linux operating system must enable SELinux. 
 # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

se_linux=$(sudo getenforce)
if [ "$se_linux" != "Enforcing" ]
then
	result='Open'
	finding="$se_linux"
else
	result="NotAFinding"
fi

 echo "V-71989 - SV-86613r4_rule - $result - $finding"  
