# perl_shop
Boutique en ligne avec gestion des stocks entièrement écrite en langage Perl.

## Installation

**Pour des raisons de sécurité, il est déconseillé de mettre les sources dans une arborescence de fichier accessible depuis le web. En cas de mauvaise configuration de votre serveur web ils pourraient êtres visibles publiquement.**

###Téléchargez les sources :

```
$ cd [pathToSource]
$ git clone https://github.com/Moudex/perl_shop.git
```
*[pathToSource] correspond au chemin des sources, en général /srv/www*

###Configurez Apache :

```
ScriptAliasMatch ^/perlshop/(.*) [pathToSource]/perl_shop/src/router.pl
<Directory "[pathToSource]/perl_shop/src">
    AddHandler cgi-script .pl
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch -Indexes
</Directory>
```
La première ligne indique que toutes requète éffectués dans le dossier "perlshop" (de l'arborescence de fichier accéssible du web) devras être éxecuté par le script "router.pl". Ce script décompose ensuite l'url de la requète pour appeller le controlleur correspondant.
Le reste de la configuration permet de pouvoir éxecuter les scripts .pl dans le dossier des sources.

La boutique seras accessible depuis "http://<domaine>/perlshop".
Il est possible de remplacer le préfixe *perlshop* à condition de modifier les sources (méthodes *path* du controlleur et de la vue, routeur...).

###Optionnel, le module Perl d'Apache

De la même manière que pour PHP, un module ajoutant directement le support de Perl existe pour Apache. Avec ce module, l'interpréteur Perl reste constamment en mémoire (il n'est pas chargé à chaque requètes) et chaque fichier n'est compilé qu'à la première utilisation : l'interpréteur n'a plus à relire le script encore et encore.

Ce module s'installe avec la commande suivante :
`# apt-get install libapache2-mod-perl2`

Pour activer le support d'Apache, il est nécessaire d'ajouter quelques lignes dans  un contexte particulier :
```
AliasMatch /perlshop/(.*) [pathToSource]/perl_shop/src
<Location /perlshop/>
    SetHandler perl-script
    PerlResponseHandler ModPerl::Registry
    PerlOptions +ParseHeaders
    Options +ExecCGI
    Order allow,deny
    Allow from all
</Location>
```
