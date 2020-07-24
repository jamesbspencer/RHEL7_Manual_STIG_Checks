#!/bin/bash 

# V-100023 - SV-109127r1_rule - The Red Hat Enterprise Linux operating system must disable the graphical user interface automounter unless required. # Valid results are Open, NotAFinding, Not_Applicable, and Not_Reviewed 
result='Not_Reviewed' 

header=$(sudo grep -v '^#' /etc/dconf/db/local.d/00-No-Automount | grep -F "[org/gnome/desktop/media-handling]")
a_mount=$(sudo grep -v '^#' /etc/dconf/db/local.d/00-No-Automount | grep '^automount=false')
a_open=$(sudo grep -v '^#' /etc/dconf/db/local.d/00-No-Automount | grep '^automount-open=false')
a_run=$(sudo grep -v '^#' /etc/dconf/db/local.d/00-No-Automount | grep '^autorun-never=true')
other=$(sudo grep -v '^#' /etc/dconf/db/local.d/00-No-Automount | grep -v -e '^$' | grep -v -F "[org/gnome/desktop/media-handling]" | grep -v '^automount=false' | grep -v '^automount-open=false' | grep -v '^autorun-never=true')

a_mount2=$(sudo grep -v '^#' /etc/dconf/db/local.d/locks/00-No-Automount | grep -v -e '^$' | grep '^/org/gnome/desktop/media-handling/automount$')
a_open2=$(sudo grep -v '^#' /etc/dconf/db/local.d/locks/00-No-Automount | grep -v -e '^$' | grep '^/org/gnome/desktop/media-handling/automount-open$')
a_run2=$(sudo grep -v '^#' /etc/dconf/db/local.d/locks/00-No-Automount | grep -v -e '^$' | grep '^/org/gnome/desktop/media-handling/autorun-never$')
other2=$(sudo grep -v '^#' /etc/dconf/db/local.d/locks/00-No-Automount | grep -v -e '^$' | grep '^/org/gnome/desktop/media-handling/automount$' | grep '^/org/gnome/desktop/media-handling/automount-open$' | grep '^/org/gnome/desktop/media-handling/autorun-never$')


if test -n "$other" || test -n "$other2"
then
	result="Open"
	finding="One or both automount files had extra lines"
elif test -z "$header" || test -z "$a_mount" || test -z "$a_open" || test -z "$a_run" || test -z "$a_mount2" || test -z "$a_open2" || test -z "$a_run2"
then
	result="Open"
	finding="A line is missing from one of the files"
else
	result="NotAFinding"
fi

echo "V-100023 - SV-109127r1_rule - $result - $finding"  
