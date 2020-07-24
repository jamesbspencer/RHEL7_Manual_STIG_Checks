#!/bin/bash 

# V-78995 - SV-93701r3_rule - The Red Hat Enterprise Linux operating system must prevent a user from overriding the screensaver lock-enabled setting for the graphical user interface. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

desk_top=$(sudo rpm -qa | grep gnome)
if [ -n "$desk_top" ]; then
	db=$(sudo grep system-db /etc/dconf/profile/user | awk -F: '{print $2}')
	if [ "$db" = "local" ]; then
		locks=$(sudo grep -h -v ^# /etc/dconf/db/local.d/locks/* | grep -i lock-enabled)
		if [ -z "$locks" ]; then
			result='Open'
			finding="Screensaver lock can be overridden."
		else
			result='NotAFinding'
		fi
	fi
else
	result='Not_Applicable'
	finding="GNOME is not installed"
fi


echo "V-78995 - SV-93701r3_rule - $result - $finding"  
