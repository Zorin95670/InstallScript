#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script d'example d'installation d'un serveur git
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Script d'installation d'un serveur git
#	Paramètre:	
#			1° Adresse du serveur d'installation
#-------------------------------------------------------------------------------------------------------------------------

addressWeb=$1

# Ajout de l'utilisateur git
adduser --system --shell /bin/bash --group --disabled-password --home /var/git/ git
chown git:git /var/git

# installation de git
apt-get install -y git

# Ajout du script de création de dépôt à la racine de l'utilisateur git
wget -P /var/git/ $addressWeb/Debian/GitServer/createDepot.sh

