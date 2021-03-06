#!/bin/bash 

# V-72031 - SV-86655r4_rule - The Red Hat Enterprise Linux operating system must be configured so that all local initialization files for local interactive users are be group-owned by the users primary group or root. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
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
		for i in $(sudo find $home -type f -iname '.*')
		do
			rights=$(sudo stat -c %g $i)
			#echo "$id $gid $rights $i"
			if ! [[ "$rights" =~ ^("$gid"|0)$ ]]; then
				result='Open'
				finding="$id $gid $rights $i"
				break
			else
				result="NotAFinding"
			fi
		done
	fi
done


echo "V-72031 - SV-86655r4_rule - $result - $finding"  
