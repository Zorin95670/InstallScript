#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'installation du ssh
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.1
#	Description:
#			Installe et configure le ssh d'un serveur ssh pour un serveur debian.
#			
#	Paramètre:	
#			1° Liste d'utilisateur autorisé, si vide alors : user
#-------------------------------------------------------------------------------------------------------------------------

# Création du répertoire des logs d'installation
logFile=/var/log/InstallServer/ssh/log.txt
mkdir -p /var/log/InstallServer/ssh

# Définition des utilisateurs
if [ -z ${1+x} ]; then 
	user="user"; 
else 
	user="$1" 
fi

# Demande le port
port=0
while [ $port = 0 ]
do
	read -p 'Numéro de port pour le ssh? ' response
	if [ $response -le 0 ]; then
		port=0
	else
		port=$response
	fi
done

# Demande l'adresse d'écoute
read -p 'Adresse ip à écouter? ' address

# Installation du paquet pour un serveur ssh
echo -e "\e[1mINFO\e[0m - Installation openssh paquet"
apt-get install -y openssh-server

echo "#### Networking options ####

# Listen on a non-standard port > 1024
Port $port

# Restrict to IPv4. inet = IPv4, inet6 = IPv6, any = both 
AddressFamily inet

# Listen only on the internal network address
ListenAddress $address

# Only use protocol version 2
Protocol 2

# Disable XForwarding unless you need it
X11Forwarding no

# Disable TCPKeepAlive and use ClientAliveInterval instead to prevent TCP Spoofing attacks
TCPKeepAlive no
ClientAliveInterval 600
ClientAliveCountMax 3

#### Networking options ####


#### Key Configuration ####

# HostKeys for protocol version 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key

#Privilege Separation is turned on for security
UsePrivilegeSeparation yes

# Use public key authentication
PubkeyAuthentication yes
AuthorizedKeysFile      %h/.ssh/authorized_keys

# Disable black listed key usage (update your keys!)
PermitBlacklistedKeys no

#### Key Configuration ####


#### Authentication ####

# Whitelist allowed users
AllowUsers $user

# one minute to enter your key passphrase
LoginGraceTime 60

# No root login
PermitRootLogin no

# Force permissions checks on keyfiles and directories
StrictModes yes

# Don't read the user's ~/.rhosts and ~/.shosts files
IgnoreRhosts yes

# similar for protocol version 2
HostbasedAuthentication no

# Don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication
IgnoreUserKnownHosts yes

# To enable empty passwords, change to yes (NOT RECOMMENDED)
PermitEmptyPasswords no

# Disable challenge and response auth. Unessisary when using keys
ChallengeResponseAuthentication no

# Disable the use of passwords completly, only use public/private keys
PasswordAuthentication no

# Using keys, no need for PAM. Also allows SSHD to be run as a non-root user
UsePAM no

# Don't use login(1)
UseLogin no

#### Authentication ####


#### Misc ####

# Logging
SyslogFacility AUTH
LogLevel INFO

# Print the last time the user logged in
PrintLastLog yes

MaxAuthTries 2

MaxStartups 10:30:60

# Display login banner
Banner /etc/issue.net

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

Subsystem sftp /usr/lib/openssh/sftp-server

#### Misc ####
" > /etc/ssh/sshd_config

# Redémare le service ssh
echo -e "\e[1mINFO\e[0m - Restart ssh"
/etc/init.d/ssh restart
