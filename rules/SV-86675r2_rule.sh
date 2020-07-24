#!/bin/bash 

# V-72051 - SV-86675r2_rule - The Red Hat Enterprise Linux operating system must have cron logging implemented. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

cron=$(sudo grep cron /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
msgs=$(sudo grep -v ^# /etc/rsyslog.conf /etc/rsyslog.d/* | grep /var/log/messages)
if [ -z "$cron" ] || [ -z "$msgs" ]
then
	result='Open'
else
	result="NotAFinding"
fi


echo "V-72051 - SV-86675r2_rule - $result"  
