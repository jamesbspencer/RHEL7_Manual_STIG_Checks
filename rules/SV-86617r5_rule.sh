#!/bin/bash 

# V-71993 - SV-86617r5_rule - The Red Hat Enterprise Linux operating system must be configured so that the x86 Ctrl-Alt-Delete key sequence is disabled on the command line. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

mask=$(sudo systemctl status ctrl-alt-del.target | grep Loaded | awk -F: '{print $2}' | awk -F\( '{print $1}')
activ=$(sudo systemctl status ctrl-alt-del.target | grep Active | awk -F: '{print $2}' | awk -F\( '{print $1}')
if [[ ! "$mask" =~ masked ]] && [[ ! "$activ" =~ inactive ]]; then
	result='Open'
else
	result="NotAFinding"
fi


echo "V-71993 - SV-86617r5_rule - $result"  
