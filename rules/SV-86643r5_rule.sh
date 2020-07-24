#!/bin/bash 

# V-72019 - SV-86643r5_rule - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user home directories are owned by their respective users. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

min=$(sudo awk '$1 == "UID_MIN"{print $2}' /etc/login.defs | tr -d '[:space:]')
max=$(sudo awk '$1 == "UID_MAX"{print $2}' /etc/login.defs | tr -d '[:space:]') 
for user in $(sudo awk -F: '($3 <= $max)&&($7 !~ "nologin"){print $1":"$3":"$6}' /etc/passwd)
do
	id=$(echo $user | awk -F: '{print $1}')
	uid=$(echo $user | awk -F: '{print $2}')
	home=$(echo $user | awk -F: '{print $3}')
	if [ $uid -gt $min ]; then
		uid_dir=$(sudo stat -c %u $home)
		if [ $uid -ne $uid_dir ]; then
			result="Open"
			finding="$uid"
			break
		else
			result="NotAFinding"
		fi
	fi
done

echo "V-72019 - SV-86643r5_rule - $result - $finding"
