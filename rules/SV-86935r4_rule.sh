#!/bin/bash 

# V-72311 - SV-86935r4_rule - The Red Hat Enterprise Linux operating system must be configured so that the Network File System (NFS) is configured to use RPCSEC_GSS. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

nfs_mounts=$(sudo grep -v ^# /etc/fstab | grep nfs)
OIFS=$IFS
IFS=$'\n'
if [ -n "$nfs_mounts" ]; then
	for line in ${nfs_mounts}; do
		if ! [[ "$line" =~ "krb5:krb5i:krb5p" ]]; then
			result='Open'
			finding="krb5 is not in settings"
			break
		else
			result="NotAFinding"
		fi
	done
else
	result="NotAFinding"
fi

IFS=$OIFS

echo "V-72311 - SV-86935r4_rule - $result - $finding"  
