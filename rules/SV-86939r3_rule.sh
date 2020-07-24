#!/bin/bash 

# V-72315 - SV-86939r3_rule - The Red Hat Enterprise Linux operating system access control program must be configured to grant or deny system access to specific hosts and services. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

enabled=$(sudo systemctl show firewalld --property=UnitFileState | awk -F= '{print $2}')
active=$(sudo systemctl show firewalld --property=ActiveState | awk -F= '{print $2}')
hosts_deny=$(sudo grep -v ^# /etc/hosts.deny)
hosts_allow=$(sudo grep -v ^# /etc/hosts.allow)
if [ "$enabled" = "enabled" ] && [ "$active" = "active" ]; then
	zone=$(sudo firewall-cmd --get-default-zone)
	ports=$(sudo firewall-cmd --zone=$zone --list-ports)
	services=$(sudo firewall-cmd --zone=$zone --list-services)
	rules=$(sudo firewall-cmd --zone=$zone --direct --get-all-rules)
	if [ -n "$zone" ] || [ -n "$ports" ] || [ -n "$services" ] || [ -n "$rules" ]; then
		result='NotAFinding'
	else
		result='Open'
		finding="Firewall is not set right"
	fi
elif [ -n "$hosts_allow" ] && [ -n "$hosts_deny" ]; then
	result="NotAFinding"
else
	result="Open"
	finding="Firewalld is not running and tcpwrappers is not being used"
fi

echo "V-72315 - SV-86939r3_rule - $result - $finding"  
