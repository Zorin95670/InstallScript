# InstallScript
Script d'installation pour serveur linux. 

Pour que tout marche correctement :

- il faut copier l'ensemble des répertoires dans le dossier web d'un serveur apache.
- modifier les adresses du serveur dans les scripts addressWeb=http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE par l'adresse de votre serveur

Exemple :
Installation d'un serveur apache sur l'adresse suivante 192.168.1.1
Création du dossier des installation sous /var/www/html/InstallServeur
Copie l'ensemble des scripts sous le répertoire précédent
le repertoire doit avoir l'architecture suivantes :
var
└── www
	└── html
		└── InstallServeur
			└── Debian
			    ├── ApacheServer
			    ├── GitServer
			    │   ├── createDepot.sh
			    │   └── install.sh
			    ├── ssh
			    │   └── install.sh
			    └── TomcatServer
			        ├── 7
			        │   └── install.sh
			        └── 8
			            └── install.sh

On modifie la variable de la façon suivante :
addressWeb=http://192.168.1.1/InstallServeur 
