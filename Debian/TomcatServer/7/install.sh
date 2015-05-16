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

su

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

# Installation de Tomcat7
apt-get install -y tomcat7 tomcat7-admin
echo "
<tomcat-users>
    <user username=\"$tomcatUser\" password=\"$tomcatPwd\" roles=\"manager-gui,admin-gui\"/>
</tomcat-users>
" > /etc/tomcat7/tomcat-users.xml

# Redémarre le serveur tomcat
service tomcat7 restart
