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

su

# Création du répertoire des logs d'installation
mkdir -p /var/log/InstallServer

# Demande si on veut installer le ssh
ssh=0
while [ $ssh = 0 ]
do
	read -p 'Voulez-vous installer le ssh (y/n)? ' response
	if [ $response = 'y' ] || [ $response = 'n' ]; then
		ssh=1
	fi
done

# Installation du ssh
if [ $ssh = 1 ]; then
	mkdir -p $HOME/INSTALL/ssh
	wget -P $HOME/INSTALL/ssh $addressWeb/Debian/ssh/install.sh
	sh $HOME/INSTALL/ssh/install.sh
fi
