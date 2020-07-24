#!/bin/bash 

# V-72273 - SV-86897r2_rule - The Red Hat Enterprise Linux operating system must enable an application firewall, if available. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

enabled=$(sudo systemctl show firewalld --property=UnitFileState | awk -F= '{print $2}')
active=$(sudo systemctl show firewalld --property=ActiveState | awk -F= '{print $2}')
if [ "$enabled" = "enabled" ] && [ "$active" = "active" ]; then
	state=$(sudo firewall-cmd --state)
	if [[ "$state" != "running" ]]; then
		result="Open"
		finding="Firewalld isn't running"
	else
		result="NotAFinding"
	fi
else
	result='Open'
	finding="Firewalld isn't running"
fi

echo "V-72273 - SV-86897r2_rule - $result - $finding" 
