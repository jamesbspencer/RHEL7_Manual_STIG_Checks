#!/bin/bash 

# V-72039 - SV-86663r2_rule - The Red Hat Enterprise Linux operating system must be configured so that all system device files are correctly labeled to prevent unauthorized modification. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

lbla=$(sudo find /dev -context *:device_t:* \( -type c -o -type b \) -printf "%p %Z\n")
lblb=$(sudo find /dev -context *:unlabeled_t:* \( -type c -o -type b \) -printf "%p %Z\n")
if [ ! -z "$lbla" ] && [ ! -z "$lblb" ]; then
	result='Open'
	finding="$lbla $lblb"
else
	result="NotAFinding"
fi

echo "V-72039 - SV-86663r2_rule - $result - $finding"  
