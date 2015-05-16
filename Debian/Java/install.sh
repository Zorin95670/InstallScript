#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'installation de Java
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Script d'installation de java
#-------------------------------------------------------------------------------------------------------------------------

# Demande le type d'installation de java voulu
javaType=0
while [ $javaType = 0 ]
do
	echo "
Quel type d'installation java voulez-vous :
\t 1 - OpenJDK 7
\t 2 - Oracle 7
\t 3 - Oracle 8
 "
	read -p 'Indiquez le numéro du type à installer :' javaType
	if [ $javaType != 1 ] || [ $javaType != 2 ] || [ $javaType != 3 ]; then
		typeInstall=0
		echo "Numéro de type incorrecte."
	fi
done

# Installation de java
if [ $javaType = 1 ]; then
	# OpenJDK 7
	apt-get install -y openjdk-7-jdk
	javaVersion=$(update-java-alternatives --list | grep 'openjdk' | grep '7' | grep -Eo '^[^ ]+')
	update-java-alternatives --set $javaVersion

elif [ $javaType = 2 ]; then
	# Oracle 7
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get install -y oracle-java7-installer=7u76-0~webupd8~1
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
	apt-get install -y oracle-java7-set-default
	
elif [ $javaType = 3 ]; then
	# Oracle 8
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
	apt-get update
	apt-get install -y oracle-java8-installer
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	apt-get install -y oracle-java8-set-default
	
fi
