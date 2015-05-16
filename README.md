# InstallScript
Script d'installation pour serveur linux. 

Pour que tout marche correctement :

- il faut copier l'ensemble des répertoires dans le dossier web d'un serveur apache.

- modifier les adresses du serveur dans les scripts addressWeb=http://ADRESSE\_DE\_BASE/REPERTOIRE\_PRINCIPALE par l'adresse de votre serveur

## Lancement 

Pour lancer un script d'installation :

* Devenir administrateur grâce à la commande : `su`
* Récupérer le script grâce à la commande : 

`wget http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE/SCRIPT_VOULU`

*Note : Le script à la racine du système d'exploitation vous permet de choisir le type d'installation voulu, il est préférrable de l'utiliser.*

*Exemple :*

*`http://ADRESSE_DE_BASE/REPERTOIRE_PRINCIPALE/Debian/install.sh`*

*Vous permet de choisir le type de serveur à installer pour une Debian.*

* L'éxécuter grâce à la commande : `sh install.sh`

## Exemple
Installation d'un serveur apache sur l'adresse suivante 192.168.1.1

Création du dossier des installation sous /var/www/html/InstallServeur

Copie l'ensemble des scripts sous le répertoire précédent

le repertoire doit avoir l'architecture suivantes :

<pre>
var
└── www
    └── html
        └── InstallServeur
            └── Debian
                ├── install.sh
                ├── ApacheServer
                ├── GitServer
                │   ├── createDepot.sh
                │   └── install.sh
                ├── ssh
                │   └── install.sh
                └── TomcatServer
                    ├── 7
                    │   └── install.sh
                    └── 8
                        └── install.sh
</pre>		            

On modifie la variable de la façon suivante :

addressWeb=http://192.168.1.1/InstallServeur 

## Sources
- <a href="https://www.sheevaboite.fr/articles/installer-serveur-git-auto-heberge-partie-1" target="blank">Source d'installation du serveur git</a>
- <a href="http://www.webupd8.org/2012/06/how-to-install-oracle-java-7-in-debian.html" target="blank">Source d'installation de oracle java 7</a>
- <a href="http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html" target="blank">Source d'installation de oracle java 8</a>
- <a href="http://ubuntuforums.org/showthread.php?t=831372" target="blank">Source d'installation du ssh</a>
