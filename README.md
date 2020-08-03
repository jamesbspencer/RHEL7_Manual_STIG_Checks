# Red Hat Linux 7 STIG Manual Checks
This is a collection of scripts that help to automate the process of performing the checks on STIG items left over from using the SCAP scanning tool. 

###### Updated for STIG Version 2 Release 8 and SCAP Version 2 Release 8, July 24, 2020

## Installation
Download the latest package file and extract. Copy all files and folders to your jump server, if you have one. 

## Usage
If you have Ansible, use the supplied .yml file to push stig_checks.zip to your systems, run the scan, and pull back the results. Or you can copy stig_checks.zip to the server you want to check, extract, and run stig_check.sh. Once you have the results file, in .ckl format. Import it into an existing STIG checklist.

## File Descriptions
- stig_checks.sh - Loops through the shell scripts in the rules folder and populates the base checklist with STIG check results.
- ~ManualChecks.ckl - The base checklist. The STIG checklist rules leftover from subtracting a SCAP profile from a STIG checklist.
- tools/Create-ManualChecklistFile.ps1 - A Powershell script that subtracts a SCAP profile from a STIG checklist to create our ~ManuaChecks.ckl file.
- *ansible_push_stig_checks.yml - (Optional) An Ansible playbook that pushes the rules folder, stig_checks.sh, and ~ManualChecks.ckl to the server(s) to be checked, executes the scripts, and pulls back the results. 

## CHANGES for this version
- SV-86485r5_rule - V-71861 - NEW - Previously in SCAP benchmark. Graphical User Interface Logon Banner. 
- SV-86487r3_rule - V-71863 - NEW - Previously in SCAP benchmark. Logon Banner.
- SV-86849r5_rule - V-72225 - NEW - Previously in SCAP benchmark. Logon Banner.
- SV-86567r6_rule - V-71943 - UPDATED - Finding for deny changed to greater than 3 and not 0. 
- SV-86595r4_rule - V-71971 - UPDATED - No longer Not Applicable if HIPS or HBSS is being used.
- SV-86613r4_rule - V-71989 - UPDATED - No longer Not Applicable if HIPS or HBSS is being used.
- SV-86615r6_rule - V-71991 - UPDATED - No longer Not Applicable if HIPS or HBSS is being used. 
- SV-86697r4_rule - V-72073 - UPDATED - No longer a finding if aide isn't installed and another file integrity checker is being used.
- SV-86847r5_rule - V-72223 - UPDATED - Increased TMOUT to 900 seconds or less.
- SV-95725r3_rule - V-81013 - UPDATED - Merged with V-81009 and V-81011.
- SV-102357r2_rule - V-92255 - UPDATED - Updated verbage to include selinux as an alternative to hips.
- SV-95721r2_rule - V-81009 - REMOVED - Combined with V-81013.
- SV-95723r2_rule - V-81011 - REMOVED - Combined with V-81013.

## Includes shell scripts for the following rules
- SV-86473r4_rule - V-71849 - The Red Hat Enterprise Linux operating system must be configured so that the file permissions, ownership, and group membership of system files and commands match the vendor values.
- SV-86485r5_rule - V-71861 - The Red Hat Enterprise Linux operating system must display the approved Standard Mandatory DoD Notice and Consent Banner before granting local or remote access to the system via a graphical user logon.
- SV-86487r3_rule - V-71863 - The Red Hat Enterprise Linux operating system must display the Standard Mandatory DoD Notice and Consent Banner before granting local or remote access to the system via a command line user logon.
- SV-86567r6_rule - V-71943 - The Red Hat Enterprise Linux operating system must be configured to lock accounts for a minimum of 15 minutes after three unsuccessful logon attempts within a 15-minute timeframe.
- SV-86569r4_rule - V-71945 - The Red Hat Enterprise Linux operating system must lock the associated account after three unsuccessful root logon attempts are made within a 15-minute period.
- SV-86589r2_rule - V-71965 - The Red Hat Enterprise Linux operating system must uniquely identify and must authenticate organizational users (or processes acting on behalf of organizational users) using multifactor authentication.
- SV-86595r4_rule - V-71971 - The Red Hat Enterprise Linux operating system must prevent non-privileged users from executing privileged functions to include disabling, circumventing, or altering implemented security safeguards/countermeasures.
- SV-86599r2_rule - V-71975 - The Red Hat Enterprise Linux operating system must be configured so that designated personnel are notified if baseline configurations are changed in an unauthorized manner.
- SV-86613r4_rule - V-71989 - The Red Hat Enterprise Linux operating system must enable SELinux.
- SV-86615r6_rule - V-71991 - The Red Hat Enterprise Linux operating system must enable the SELinux targeted policy.
- SV-86617r5_rule - V-71993 - The Red Hat Enterprise Linux operating system must be configured so that the x86 Ctrl-Alt-Delete key sequence is disabled on the command line.
- SV-86623r4_rule - V-71999 - The Red Hat Enterprise Linux operating system security patches and updates must be installed and up to date.
- SV-86625r2_rule - V-72001 - The Red Hat Enterprise Linux operating system must not have unnecessary accounts.
- SV-86631r3_rule - V-72007 - The Red Hat Enterprise Linux operating system must be configured so that all files and directories have a valid owner.
- SV-86633r3_rule - V-72009 - The Red Hat Enterprise Linux operating system must be configured so that all files and directories have a valid group owner.
- SV-86641r3_rule - V-72017 - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user home directories have mode 0750 or less permissive.
- SV-86643r5_rule - V-72019 - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user home directories are owned by their respective users.
- SV-86645r5_rule - V-72021 - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user home directories are group-owned by the home directory owners primary group.
- SV-86647r2_rule - V-72023 - The Red Hat Enterprise Linux operating system must be configured so that all files and directories contained in local interactive user home directories are owned by the owner of the home directory.
- SV-86649r2_rule - V-72025 - The Red Hat Enterprise Linux operating system must be configured so that all files and directories contained in local interactive user home directories are group-owned by a group of which the home directory owner is a member.
- SV-86651r2_rule - V-72027 - The Red Hat Enterprise Linux operating system must be configured so that all files and directories contained in local interactive user home directories have a mode of 0750 or less permissive.
- SV-86653r4_rule - V-72029 - The Red Hat Enterprise Linux operating system must be configured so that all local initialization files for interactive users are owned by the home directory user or root.
- SV-86655r4_rule - V-72031 - The Red Hat Enterprise Linux operating system must be configured so that all local initialization files for local interactive users are be group-owned by the users primary group or root.
- SV-86657r3_rule - V-72033 - The Red Hat Enterprise Linux operating system must be configured so that all local initialization files have mode 0740 or less permissive.
- SV-86659r4_rule - V-72035 - The Red Hat Enterprise Linux operating system must be configured so that all local interactive user initialization files executable search paths contain only paths that resolve to the users home directory.
- SV-86661r2_rule - V-72037 - The Red Hat Enterprise Linux operating system must be configured so that local initialization files do not execute world-writable programs.
- SV-86663r2_rule - V-72039 - The Red Hat Enterprise Linux operating system must be configured so that all system device files are correctly labeled to prevent unauthorized modification.
- SV-86665r4_rule - V-72041 - The Red Hat Enterprise Linux operating system must be configured so that file systems containing user home directories are mounted to prevent files with the setuid and setgid bit set from being executed.
- SV-86667r2_rule - V-72043 - The Red Hat Enterprise Linux operating system must prevent files with the setuid and setgid bit set from being executed on file systems that are used with removable media.
- SV-86673r2_rule - V-72049 - The Red Hat Enterprise Linux operating system must set the umask value to 077 for all local interactive user accounts.
- SV-86675r2_rule - V-72051 - The Red Hat Enterprise Linux operating system must have cron logging implemented.
- SV-86681r2_rule - V-72057 - The Red Hat Enterprise Linux operating system must disable Kernel core dumps unless needed.
- SV-86693r3_rule - V-72069 - The Red Hat Enterprise Linux operating system must be configured so that the file integrity tool is configured to verify Access Control Lists (ACLs).
- SV-86695r3_rule - V-72071 - The Red Hat Enterprise Linux operating system must be configured so that the file integrity tool is configured to verify extended attributes.
- SV-86697r4_rule - V-72073 - The Red Hat Enterprise Linux operating system must use a file integrity tool that is configured to use FIPS 140-2 approved cryptographic hashes for validating file contents and directories.
- SV-86699r2_rule - V-72075 - The Red Hat Enterprise Linux operating system must not allow removable media to be used as the boot loader unless approved.
- SV-86713r4_rule - V-72089 - The Red Hat Enterprise Linux operating system must initiate an action to notify the System Administrator (SA) and Information System Security Officer ISSO, at a minimum, when allocated audit record storage volume reaches 75% of the repository maximum audit record storage capacity.
- SV-86833r2_rule - V-72209 - The Red Hat Enterprise Linux operating system must send rsyslog output to a log aggregation server.
- SV-86835r2_rule - V-72211 - The Red Hat Enterprise Linux operating system must be configured so that the rsyslog daemon does not accept log messages from other servers unless the server is being used for log aggregation.
- SV-86837r3_rule - V-72213 - The Red Hat Enterprise Linux operating system must use a virus scan program.
- SV-86843r2_rule - V-72219 - The Red Hat Enterprise Linux operating system must be configured to prohibit or restrict the use of functions, ports, protocols, and/or services, as defined in the Ports, Protocols, and Services Management Component Local Service Assessment (PPSM CLSA) and vulnerability assessments.
- SV-86847r5_rule - V-72223 - The Red Hat Enterprise Linux operating system must be configured so that all network connections associated with a communication session are terminated at the end of the session or after 15 minutes of inactivity from the user at a command prompt, except to fulfill documented and validated mission requirements.
- SV-86849r5_rule - V-72225 - The Red Hat Enterprise Linux operating system must display the Standard Mandatory DoD Notice and Consent Banner immediately prior to, or as part of, remote access logon prompts.
- SV-86851r4_rule - V-72227 - The Red Hat Enterprise Linux operating system must implement cryptography to protect the integrity of Lightweight Directory Access Protocol (LDAP) authentication communications.
- SV-86853r4_rule - V-72229 - The Red Hat Enterprise Linux operating system must implement cryptography to protect the integrity of Lightweight Directory Access Protocol (LDAP) communications.
- SV-86855r4_rule - V-72231 - The Red Hat Enterprise Linux operating system must implement cryptography to protect the integrity of Lightweight Directory Access Protocol (LDAP) communications.
- SV-86859r3_rule - V-72235 - The Red Hat Enterprise Linux operating system must be configured so that all networked systems use SSH for confidentiality and integrity of transmitted and received information as well as information during preparation for transmission.
- SV-86893r5_rule - V-72269 - The Red Hat Enterprise Linux operating system must, for networked systems, synchronize clocks with a server that is synchronized to one of the redundant United States Naval Observatory (USNO) time servers, a time server designated for the appropriate DoD network (NIPRNet/SIPRNet), and/or the Global Positioning System (GPS).
- SV-86897r2_rule - V-72273 - The Red Hat Enterprise Linux operating system must enable an application firewall, if available.
- SV-86905r3_rule - V-72281 - For Red Hat Enterprise Linux operating systems using DNS resolution, at least two name servers must be configured.
- SV-86919r2_rule - V-72295 - Network interfaces configured on the Red Hat Enterprise Linux operating system must not be in promiscuous mode.
- SV-86921r3_rule - V-72297 - The Red Hat Enterprise Linux operating system must be configured to prevent unrestricted mail relaying.
- SV-86929r3_rule - V-72305 - The Red Hat Enterprise Linux operating system must be configured so that if the Trivial File Transfer Protocol (TFTP) server is required, the TFTP daemon is configured to operate in secure mode.
- SV-86935r4_rule - V-72311 - The Red Hat Enterprise Linux operating system must be configured so that the Network File System (NFS) is configured to use RPCSEC_GSS.
- SV-86939r3_rule - V-72315 - The Red Hat Enterprise Linux operating system access control program must be configured to grant or deny system access to specific hosts and services.
- SV-86941r2_rule - V-72317 - The Red Hat Enterprise Linux operating system must not have unauthorized IP tunnels configured.
- SV-87809r4_rule - V-73157 - The Red Hat Enterprise Linux operating system must prevent a user from overriding the session idle-delay setting for the graphical user interface.
- SV-87829r2_rule - V-73177 - The Red Hat Enterprise Linux operating system must be configured so that all wireless network adapters are disabled.
- SV-93701r3_rule - V-78995 - The Red Hat Enterprise Linux operating system must prevent a user from overriding the screensaver lock-enabled setting for the graphical user interface.
- SV-95725r3_rule - V-81013 - The Red Hat Enterprise Linux operating system must mount /dev/shm with secure options.
- SV-102353r1_rule - V-92251 - The Red Hat Enterprise Linux operating system must use a reverse-path filter for IPv4 network traffic when possible on all interfaces.
- SV-102355r1_rule - V-92253 - The Red Hat Enterprise Linux operating system must use a reverse-path filter for IPv4 network traffic when possible by default.
- SV-102357r2_rule - V-92255 - The Red Hat Enterprise Linux operating system must have a host-based intrusion detection tool installed.
- SV-104673r2_rule - V-94843 - The Red Hat Enterprise Linux operating system must be configured so that the x86 Ctrl-Alt-Delete key sequence is disabled in the Graphical User Interface.
- SV-109127r1_rule - V-100023 - The Red Hat Enterprise Linux operating system must disable the graphical user interface automounter unless required.
