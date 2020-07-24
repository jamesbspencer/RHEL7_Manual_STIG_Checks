#!/bin/bash 

 # V-71849 - SV-86473r4_rule - The Red Hat Enterprise Linux operating system must be configured so that the file permissions, ownership, and group membership of system files and commands match the vendor values. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

for i in $(sudo rpm -Va | egrep -i '^\.[M|U|G|.]{8}' | cut -d " " -f4,5)
do
	for j in $(sudo rpm -qf $i)
	do 
		test=$(sudo rpm -ql $j --dump | cut -d " " -f1,5,6,7 | grep $i)
		o_perms=$(echo $test | awk '{print $2}' | tail -c -4)
		c_perms=$(stat -c %a $i)
		f_type=$(stat -c %F $i)
		if [ "$c_perms" -gt "$o_perms" ] && [[ "$f_type" =~ file ]]
		then
			result="Open"
			finding="$i"
			break
		else
			result="NotAFinding"
		fi
	done
done


 echo "V-71849 - SV-86473r4_rule - $result - $finding"  
