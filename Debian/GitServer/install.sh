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
#-------------------------------------------------------------------------------------------------------------------------

addressWeb=http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE

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

# Ajout de l'utilisateur git
adduser --system --shell /bin/bash --group --disabled-password --home /var/git/ git
chown git:git /var/git

# Installation du ssh
if [ $ssh = 1 ]; then
	mkdir -p $HOME/INSTALL/ssh
	wget -P $HOME/INSTALL/ssh $addressWeb/Debian/ssh/install.sh
	sh $HOME/INSTALL/ssh/install.sh git
fi

# installation de git
apt-get install -y git

# Ajout du script de création de dépôt à la racine de l'utilisateur git
wget -P /var/git/ $addressWeb/Debian/GitServer/createDepot.sh

