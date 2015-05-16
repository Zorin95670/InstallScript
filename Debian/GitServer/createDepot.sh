#!/bin/bash
# ------------------------------------------------------------------------------------------------------------------------
#                                               Script de création d'un dépôt git
#
#	Auteur: 	Moittie Vincent
#	Date:		2015
#	OS :		Debian
#	Version :	8
#	Script-Version : 1.0.0
#	Description:
#			Script de création d'un dépôt git
#	Paramètre:	
#			1° Nom du dépôt git
#-------------------------------------------------------------------------------------------------------------------------

if [ -z ${1+x} ]; then 
	echo "Erreur aucun nom de dépôt renseigné."
else 
	mkdir /var/git/$1.git
	cd /var/git/$1.git
	git init --bare
	chown -R git:git /var/git/$1.git
fi
