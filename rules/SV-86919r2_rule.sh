#!/bin/bash 

# V-72295 - SV-86919r2_rule - Network interfaces configured on the Red Hat Enterprise Linux operating system must not be in promiscuous mode. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

promisc=$(sudo ip link | grep promisc)
if [ -n "$promisc" ]; then
	result='Open'
	finding="$promisc"
else
	result="NotAFinding"
fi

echo "V-72295 - SV-86919r2_rule - $result - $finding"  
