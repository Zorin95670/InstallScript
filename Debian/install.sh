#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                               Script principal d'installation d'un serveur Debian
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Installation principale d'un serveur debian, avec le choix du type d'installation.
#
#-------------------------------------------------------------------------------------------------------------------------

addressWeb=https://github.com/Zorin95670/InstallScript

# Création du répertoire des logs d'installation
mkdir -p /var/log/InstallServer

# Demande le type d'installation voulu
typeInstall=-1
while [ $typeInstall = -1 ]
do
	echo "
Quel type de serveur voulez-vous installer :
\t 0 - Installation basique
\t 1 - Serveur Apache
\t 2 - Serveur git
\t 3 - Serveur Tomcat 7
\t 4 - Serveur Tomcat 8
 "
	read -p 'Indiquez le numéro du serveur à installer :' typeInstall
	if [ $typeInstall != 0 ] && [ $typeInstall != 1 ] && [ $typeInstall != 2 ] && [ $typeInstall != 3 ] && [ $typeInstall != 4 ]; then
		typeInstall=-1
		echo -e "\e[1;31mErreur - Type d'installation incorrecte.\e[0m"
	fi
done

# Demande si on veut installer le ssh
network=0
while [ $ssh = 0 ]
do
	read -p 'Voulez-vous configurer la carte réseau (y/n)? ' response
	if [ $response = 'y' ]; then
		network=1
	elif [ $response = 'n' ]; then
		network=2
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
	echo -e "\e[1mINFO\e[0m - début configuration du réseau"
	mkdir -p $HOME/INSTALL/Networking
	wget -P $HOME/INSTALL/Networking $addressWeb/Debian/Networking/install.sh
	if [ $typeInstall = 2 ]; then
		sh $HOME/INSTALL/Networking/install.sh git
	else
		sh $HOME/INSTALL/Networking/install.sh
	fi
fi

# Installation du ssh
if [ $ssh = 1 ]; then
	echo -e "\e[1mINFO\e[0m - début installation du ssh"
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
	echo -e "\e[1mINFO\e[0m - début installation de Java"
	mkdir -p $HOME/INSTALL/Java
	wget -P $HOME/INSTALL/Java $addressWeb/Debian/Java/install.sh
	sh $HOME/INSTALL/Java/install.sh

fi

# Installation du serveur
if [ $typeInstall = 1 ]; then
	echo -e "\e[1mINFO\e[0m - début installation du serveur Apache"
	mkdir -p $HOME/INSTALL/Apache
	wget -P $HOME/INSTALL/Apache $addressWeb/Debian/ApacheServer/install.sh
	sh $HOME/INSTALL/Apache/install.sh

elif [ $typeInstall = 2 ]; then
	echo -e "\e[1mINFO\e[0m - début installation du serveur Git"
	mkdir -p $HOME/INSTALL/Git
	wget -P $HOME/INSTALL/Git $addressWeb/Debian/GitServer/install.sh
	sh $HOME/INSTALL/Git/install.sh $addressWeb
	
elif [ $typeInstall = 3 ]; then
	echo -e "\e[1mINFO\e[0m - début installation du serveur Tomcat 7"
	mkdir -p $HOME/INSTALL/Tomcat7
	wget -P $HOME/INSTALL/Tomcat7 $addressWeb/Debian/TomcatServer/7/install.sh
	sh $HOME/INSTALL/Tomcat7/install.sh
	
elif [ $typeInstall = 4 ]; then
	echo -e "\e[1mINFO\e[0m - début installation du serveur Tomcat 8"
	mkdir -p $HOME/INSTALL/Tomcat8
	wget -P $HOME/INSTALL/Tomcat8 $addressWeb/Debian/TomcatServer/8/install.sh
	sh $HOME/INSTALL/Tomcat8/install.sh
	
fi

# Suppression des fichiers d'installations
echo -e "\e[1mINFO\e[0m - Suppression des fichiers d'installations"
rm -rf $HOME/INSTALL
#Demande de redemarrage de la machine
response=0
while [ $response = 0 ]
do
	read -p 'Voulez-vous redemarrer la machine (y/n)? ' response
	if [ $response = 'y' ]; then
		reboot
	elif [ $response = 'n' ]; then
		response=2
	fi
done
