#!/bin/bash 

# V-72235 - SV-86859r3_rule - The Red Hat Enterprise Linux operating system must be configured so that all networked systems use SSH for confidentiality and integrity of transmitted and received information as well as information during preparation for transmission. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

enabled=$(sudo systemctl show sshd --property=UnitFileState | awk -F= '{print $2}')
active=$(sudo systemctl show sshd --property=ActiveState | awk -F= '{print $2}')
if [[ "$enabled" != "enabled" ]] || [[ "$active" != "active" ]]; then
	result='Open'
	finding="SSHD is not running"
else
	result="NotAFinding"
fi

echo "V-72235 - SV-86859r3_rule - $result - $finding"  
