#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script de configuration du réseau
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Script permettant de configurer le réseau.
#
#-------------------------------------------------------------------------------------------------------------------------


# Demande le type d'installation voulu
typeInstall=-1
while [ $typeInstall = -1 ]
do
	echo "
Quel type de configuration réseau voulez-vous installer :
\t 0 - Aucune
\t 1 - Static
\t 2 - DHCP
 "
	read -p 'Indiquez le numéro de configuration à installer :' typeInstall
	if [ $typeInstall != 0 ] && [ $typeInstall != 1 ] && [ $typeInstall != 2 ]; then
		typeInstall=-1
		echo -e "\e[1;31mErreur - Type de configuration incorrecte.\e[0m"
	fi
done

# Configuration du réseau
if [ $typeInstall = 1 ]; then
	echo -e "\e[1mINFO\e[0m - début configuration du réseau en DHCP"
	echo "auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet dhcp" > /etc/network/interfaces
	/etc/init.d/network restart

elif [ $typeInstall = 2 ]; then
	echo -e "\e[1mINFO\e[0m - début configuration du réseau en static"
	read -p "Indiquez l'adresse ip de la machine :" address
	read -p "Indiquez le masque réseau de la machine :" netmask
	read -p "Indiquez l'adresse ip de la passerelle :" gateway
	echo "auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
	address $address
	netmask $netmask
	gateway $gateway" > /etc/network/interfaces
	
	/etc/init.d/network restart
	typeInstall=0
	while [ $typeInstall = 0 ]
	do
		read -p 'Voulez-vous configurer le dns (y/n)? ' response
		if [ $response = 'y' ]; then
			typeInstall=1
		elif [ $response = 'n' ]; then
			typeInstall=2
		fi
	done
fi
# Configuration du réseau
if [ $typeInstall = 1 ]; then
	echo -e "\e[1mINFO\e[0m - début configuration du dns"
	echo "#DNS CONFIGURATION" > /etc/resolv.conf
	dns=0
	while [ $dns = 0 ]
	do
		read -p "Indiquez l'adresse du serveur dns :" dns
		echo "nameserver $dns" >> /etc/resolv.conf
		read -p 'Voulez-vous ajoutez un serveur dns (y/n)? ' response
		if [ $response = 'y' ]; then
			dns=0
		elif [ $response = 'n' ]; then
			dns=1
		fi
	done
fi
# Demande si l'utilisateur veut configurer un proxy ?
typeInstall=0
while [ $typeInstall = 0 ]
do
	read -p 'Voulez-vous configurer un serveur proxy (y/n)? ' response
	if [ $response = 'y' ]; then
		typeInstall=1
	elif [ $response = 'n' ]; then
		typeInstall=2
	fi
done
# Configuration du réseau
if [ $typeInstall = 1 ]; then
	echo -e "\e[1mINFO\e[0m - début configuration du proxy"
	proxy=0
	endProxy="_proxy"
	while [ $proxy = 0 ]
	do
		read -p "Indiquez le type du protocole (http, ftp, https, ...) :" protocole
		read -p "Indiquez l'adresse du proxy :" address
		echo "export $protocole$endProxy=$address" >> /etc/profile
		read -p 'Voulez-vous ajoutez un autre proxy (y/n)? ' response
		if [ $response = 'y' ]; then
			proxy=0
		elif [ $response = 'n' ]; then
			proxy=1
		fi
	done
fi
