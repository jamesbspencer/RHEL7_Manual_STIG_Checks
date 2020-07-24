#!/bin/bash 

# V-94843 - SV-104673r2_rule - The Red Hat Enterprise Linux operating system must be configured so that the x86 Ctrl-Alt-Delete key sequence is disabled in the Graphical User Interface. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

gui=$(rpm -qa | grep -i gnome)
log_out=$(sudo grep -h -d skip -v ^# /etc/dconf/db/local.d/* | grep logout | awk -F= '{print $2}')

if test -z "$gui"
then
	result="Not_Applicable"
	finding="GNOME is not installed"
elif test -z "$log_out" 
then
	result='Open'
	finding="CAD setting not found"
elif ! [[ "$log_out" =~ ^\'\'$ ]]
then
	result='Open'
	finding="CAD not configured properly"
else
	result="NotAFinding"
fi

echo "V-94843 - SV-104673r2_rule - $result - $finding"  
