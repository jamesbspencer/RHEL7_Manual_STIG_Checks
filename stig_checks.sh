#!/bin/bash

## Run manual STIG checks and populate the results file.

# Move to the current directory
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
echo "$parent_path"
cd "$parent_path"

# Get the current date and time
timestamp=$(date +%Y%m%dT%H%M%S)

#Tee all output to a log file
log_file="./${timestamp}_log.txt"
exec &> >(tee -a "$log_file")

# Prepend our checklist with the server name. 
hostname=$(echo "$(sudo uname -n)" | awk '{print toupper($0)}')
# Remove a previous file if it exists
sudo rm -f ./$hostname*.ckl
file=$(ls ./*ManualChecks.ckl)
base=$(echo "$(basename $file)")

cp "$file" "./$hostname-$base"

#Gather some details
iface1=$(sudo ip -o -f inet address | awk '{print $2}' | grep -v lo | head -n 1)
domain=$(sudo hostname -d)
fqdn="${hostname}.${domain}"
ip1=$(sudo ip -o -f inet address | grep $iface1 | awk '{print $4}' | awk -F/ '{print $1}')
mac1=$(sudo ip -o link | grep $iface1 | awk -F'link/ether' '{print $2}' | awk '{print $1}')

echo $hostname
echo $domain
echo $fqdn
echo $iface1
echo $ip1
echo $mac1

# Add these entries to our file
sed -i s/server_name/$hostname/ ./$hostname*.ckl
sed -i s/0.0.0.0/$ip1/ ./$hostname*.ckl
sed -i s/00:00:00:00:00:00/$mac1/ ./$hostname*.ckl
sed -i s/$hostname.domain.tld/$fqdn/ ./$hostname*.ckl

for r in $(ls ./rules/*.sh)
do
rule_id=$(echo "$(basename $r)" | awk -F. '{print $1}')
echo "$rule_id"
output=$(bash $r)
#echo "$output"
result=$(echo "$output" | awk -F" - " '{print $3}' | xargs)
finding=$(echo "$output" | awk -F" - " '{print $4}' | xargs)
comment=$(echo "$output" | awk -F" - " '{print $5}' | xargs)
echo "$result"
echo "----------"
sed -i "/$rule_id/,/VULN/{s/Not_Reviewed/$result/}" ./$hostname*.ckl
sed -i "/$rule_id/,/VULN/{s/details/$finding/}" ./$hostname*.ckl
sed -i "/$rule_id/,/VULN/{s/comment/$comment/}" ./$hostname*.ckl
done

