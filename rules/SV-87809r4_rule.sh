#!/bin/bash 

# V-73157 - SV-87809r4_rule - The Red Hat Enterprise Linux operating system must prevent a user from overriding the session idle-delay setting for the graphical user interface. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

desk_top=$(sudo rpm -qa | grep gnome)
if [ -n "$desk_top" ]; then
	db=$(sudo grep system-db /etc/dconf/profile/user | awk -F: '{print $2}')
	if [ "$db" = "local" ]; then
		locks=$(sudo grep -h -v ^# /etc/dconf/db/local.d/locks/* | grep -i idle-delay)
		if [ -z "$locks" ]; then
			result='Open'
			finding="No GNOME session locks found"
		else
			result="NotAFinding"
			
		fi
	fi
else
	result='Not_Applicable'
	finding="GNOME is not installed"
fi


echo "V-73157 - SV-87809r4_rule - $result - $finding"  
