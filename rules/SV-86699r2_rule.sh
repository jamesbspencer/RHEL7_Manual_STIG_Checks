#!/bin/bash 

# V-72075 - SV-86699r2_rule - The Red Hat Enterprise Linux operating system must not allow removable media to be used as the boot loader unless approved. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

grub_path=$(sudo find / -name "grub.cfg")
if [[ "$grub_path" == "/boot/grub2/grub.cfg" || "$grub_path" ==  "/boot/efi/EFI/redhat/grub.cfg" ]]; then
	entry=$(sudo grep -c ^menuentry $grub_path)
	set_root=$(sudo grep -c 'set root' $grub_path)
	if ! [ "$entry" -eq "$set_root" ]
	then
		result='Open'
		finding="Not all grub entries have set root"
	else
		result="NotAFinding"
	fi
else
	result='Open'
	finding="GRUB config not in default location"
fi

echo "V-72075 - SV-86699r2_rule - $result - $finding"  
