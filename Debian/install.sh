#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'example d'installation de serveur
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Description du script d'installation
#			blabla
#	Paramètre:	
#			1° Test
#			2° Test
#			3° Test
#-------------------------------------------------------------------------------------------------------------------------

addressWeb=http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE

# Création du répertoire des logs d'installation
mkdir -p /var/log/InstallServer

# Demande le type d'installation voulu
typeInstall=0
while [ $typeInstall = 0 ]
do
	echo "
Quel type de serveur voulez-vous installer :
\t 1 - Serveur Apache
\t 2 - Serveur git
\t 3 - Serveur Tomcat 7
\t 4 - Serveur Tomcat 8
 "
	read -p 'Indiquez le numéro du serveur à installer :' typeInstall
	if [ $typeInstall != 1 ] || [ $typeInstall != 2 ] || [ $typeInstall != 3 ] || [ $typeInstall != 4 ]; then
		typeInstall=0
		echo "Numéro de serveur incorrecte."
	fi
done

# Demande si on veut installer le ssh
ssh=0
while [ $ssh = 0 ]
do
	read -p 'Voulez-vous installer le ssh (y/n)? ' response
	if [ $response = 'y' ]; then
		ssh=1
	elif [ $response = 'n' ]; then
		ssh=2
	fi
done

# Demande si on veut installer java
java=0
while [ $java = 0 ]
do
	read -p 'Voulez-vous installer java (y/n)? ' response
	if [ $response = 'y' ]; then
		java=1
	elif [ $response = 'n' ]; then
		java=2
	fi
done

# Installation du ssh
if [ $ssh = 1 ]; then
	mkdir -p $HOME/INSTALL/ssh
	wget -P $HOME/INSTALL/ssh $addressWeb/Debian/ssh/install.sh
	if [ $typeInstall = 2 ]; then
		sh $HOME/INSTALL/ssh/install.sh git
	else
		sh $HOME/INSTALL/ssh/install.sh
	fi
fi

# Installation de java
if [ $java = 1 ]; then
	mkdir -p $HOME/INSTALL/Java
	wget -P $HOME/INSTALL/Java $addressWeb/Debian/Java/install.sh
	sh $HOME/INSTALL/Java/install.sh

fi

# Installation du serveur
if [ $typeInstall = 1 ]; then
	mkdir -p $HOME/INSTALL/Apache
	wget -P $HOME/INSTALL/Apache $addressWeb/Debian/ApacheServer/install.sh
	sh $HOME/INSTALL/Apache/install.sh

elif [ $typeInstall = 2 ]; then
	mkdir -p $HOME/INSTALL/Git
	wget -P $HOME/INSTALL/Git $addressWeb/Debian/GitServer/install.sh
	sh $HOME/INSTALL/Git/install.sh $addressWeb
	
elif [ $typeInstall = 3 ]; then
	mkdir -p $HOME/INSTALL/Tomcat7
	wget -P $HOME/INSTALL/Tomcat7 $addressWeb/Debian/TomcatServer/7/install.sh
	sh $HOME/INSTALL/Tomcat7/install.sh
	
elif [ $typeInstall = 4 ]; then
	mkdir -p $HOME/INSTALL/Tomcat8
	wget -P $HOME/INSTALL/Tomcat8 $addressWeb/Debian/TomcatServer/8/install.sh
	sh $HOME/INSTALL/Tomcat8/install.sh
	
fi

# Suppression des fichiers d'installations
rm -rf $HOME/INSTALL
