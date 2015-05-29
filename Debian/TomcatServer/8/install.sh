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

# Définition de l'utilisateur de tomcat
read -p 'login administrateur: ' tomcatUser
while [ -z $tomcatUser ]; do
	read -p 'login administrateur: ' tomcatUser
done

# Définition du mot de passe de l'utilisateur
read -p 'Mot de passe administrateur: ' -s  tomcatPwd
echo ""
while [ -z $tomcatUser ]; do
	read -p 'Mot de passe administrateur: ' -s  tomcatPwd
	echo ""
done

# Installation de Tomcat8
apt-get install -y tomcat8 tomcat8-admin
echo "
<tomcat-users>
    <user username=\"$tomcatUser\" password=\"$tomcatPwd\" roles=\"manager-gui,admin-gui\"/>
</tomcat-users>
" > /etc/tomcat8/tomcat-users.xml

# Redémarre le serveur tomcat
/etc/init.s/tomcat8 restart
