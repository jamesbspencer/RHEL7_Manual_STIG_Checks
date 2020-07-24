#!/bin/bash 

# V-71999 - SV-86623r4_rule - The Red Hat Enterprise Linux operating system security patches and updates must be installed and up to date. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

days='30'
today=$(($(date +%s)/86400))
date=$(($(date +%s --date $(sudo yum history | grep U | head -1 | awk -F\| '{print $3}' | awk '{print $1}'))/86400))
since=$(($today - $date))
if [ "$since" -gt "$days" ]; then
	result='Open'
	finding="Not patched in $since days"
else
	result="NotAFinding"
fi

echo "V-71999 - SV-86623r4_rule - $result"  
