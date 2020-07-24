#!/bin/bash 

# V-72305 - SV-86929r3_rule - The Red Hat Enterprise Linux operating system must be configured so that if the Trivial File Transfer Protocol (TFTP) server is required, the TFTP daemon is configured to operate in secure mode. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

tftp_server=$(sudo rpm -qa | grep "tftp-server")
if test -z "$tftp_server"
then
	result='Not_Applicable'
	finding="TFTP is not installed"
else
	args=$(grep -i server_args /etc/xinetd.d/tftp | awk -F= '{print $2}')
	if ! [[ "$args" =~ "-s" ]]; then
		result='Open'
		finding="-s option is not in config"
	else
		result="NotAFinding"
	fi
fi

 echo "V-72305 - SV-86929r3_rule - $result - $finding"  
