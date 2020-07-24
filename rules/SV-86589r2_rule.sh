#!/bin/bash 

 # V-71965 - SV-86589r2_rule - The Red Hat Enterprise Linux operating system must uniquely identify and must authenticate organizational users (or processes acting on behalf of organizational users) using multifactor authentication. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
 result='Not_Reviewed' 

pkcs=$(sudo authconfig --test | grep "pam_pkcs11 is enabled")
sc_rem=$(sudo authconfig --test | grep "smartcard removal action")
sc_mod=$(sudo authconfig --test | grep "smartcard module")
if [ -z "$pkcs" ] || [ -z "$sc_rem" ] || [ -z "$sc_mod" ]
then
	result="Open"
	finding="Smart card is not enabled"
else
	result="NotAFinding"
fi


echo "V-71965 - SV-86589r2_rule - $result - $finding"
