# perl_shop

## Installation

Télécharger les sources :

  https://github.com/Moudex/perl_shop.git

Configurez Apache :

  ScriptAliasMatch ^/perlshop/(.*) [pathToSource]/perl_shop/src/router.pl
  <Directory "[pathToSource/perl_shop/src">
    AddHandler cgi-script .pl .pm
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch -Indexes
  </Directory>

## TODO
### Modèle
* Fonctions _delete_
* Vérifier les destructeurs
* Vérifier les données
