#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'installation de serveur Tomcat 7
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Installation d'un serveur tomcat 7.
#-------------------------------------------------------------------------------------------------------------------------

addressWeb=http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE

# Demande si on veut installer le ssh
ssh=0
while [ $ssh = 0 ]
do
	read -p 'Voulez-vous installer le ssh (y/n)? ' response
	if [ $response = 'y' ] || [ $response = 'n' ]; then
		ssh=1
	fi
done

# Définition de l'utilisateur de tomcat
read -p 'login administrateur: ' tomcatUser
while [ -z $tomcatUser ]; do
	read -p 'login administrateur: ' tomcatUser
done

# Définition du mot de passe de l'utilisateur
read -ps 'Mot de passe administrateur: ' tomcatPwd
while [ -z $tomcatUser ]; do
	read -ps 'Mot de passe administrateur: ' tomcatPwd
done

# Installation du ssh
if [ $ssh = 1 ]; then
	mkdir -p $HOME/INSTALL/ssh
	wget -P $HOME/INSTALL/ssh $addressWeb/Debian/ssh/install.sh
	sh $HOME/INSTALL/ssh/install.sh
fi

# Installation de java 7
apt-get install -y openjdk-7-jdk
javaVersion=$(update-java-alternatives --list | grep 'openjdk' | grep '7' | grep -Eo '^[^ ]+')
update-java-alternatives --set $javaVersion

# Installation de Tomcat7
apt-get install -y tomcat7 tomcat7-admin
echo "
<tomcat-users>
    <user username=\"$tomcatUser\" password=\"$tomcatPwd\" roles=\"manager-gui,admin-gui\"/>
</tomcat-users>
" > /etc/tomcat7/tomcat-users.xml

# Redémarre le serveur tomcat
service tomcat7 restart

# Suppression des script d'installation
rm -rf $HOME/INSTALL
