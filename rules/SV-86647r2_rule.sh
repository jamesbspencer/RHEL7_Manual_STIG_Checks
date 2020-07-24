#!/bin/bash 

# V-72023 - SV-86647r2_rule - The Red Hat Enterprise Linux operating system must be configured so that all files and directories contained in local interactive user home directories are owned by the owner of the home directory. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

min=$(sudo awk '$1 == "UID_MIN"{print $2}' /etc/login.defs | tr -d '[:space:]')
max=$(sudo awk '$1 == "UID_MAX"{print $2}' /etc/login.defs | tr -d '[:space:]')
for user in $(sudo awk -F: '($3 <= $max)&&($7 !~ "nologin"){print $1":"$3":"$4":"$6}' /etc/passwd)
do
	id=$(echo $user | awk -F: '{print $1}')
	uid=$(echo $user | awk -F: '{print $2}')
	gid=$(echo $user | awk -F: '{print $3}')
	home=$(echo $user | awk -F: '{print $4}')
	if [ $uid -gt $min ]; then
		for i in $(sudo find $home -type f -o -type d)
		do
			i_uid=$(sudo stat -c %u $i)
			if [ $uid -ne $i_uid ]; then
				result='Open'
				finding="$id"
				break
			else
				result="NotAFinding"
			fi
		done
	fi
done

echo "V-72023 - SV-86647r2_rule - $result - $finding"  
