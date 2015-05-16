#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'installation de serveur Tomcat 8
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Installation d'un serveur tomcat 8.
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

# Installation de java 8
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install -y oracle-java8-installer
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-set-default

# Installation de Tomcat8
apt-get install -y tomcat8 tomcat8-admin
echo "
<tomcat-users>
    <user username=\"$tomcatUser\" password=\"$tomcatPwd\" roles=\"manager-gui,admin-gui\"/>
</tomcat-users>
" > /etc/tomcat8/tomcat-users.xml

# Redémarre le serveur tomcat
service tomcat8 restart

# Suppression des script d'installation
rm -rf $HOME/INSTALL
