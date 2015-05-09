# perl_shop
Boutique en ligne avec gestion des stocks entièrement écrite en langage Perl.

## Installation

Pour des raisons de sécurité, il est conseillé de ne pas mettre les sources dans un système de fichier accèssible depuis le web. En cas de mauvaise configuration de votre serveur web il pourraient êtres visibles publiquement.

Téléchargez les sources :

```
$ cd [pathToSource]
$ git clone https://github.com/Moudex/perl_shop.git
```
*[pathToSource] correspond au chemin des sources*

Configurez Apache :

```
ScriptAliasMatch ^/perlshop/(.*) [pathToSource]/perl_shop/src/router.pl
<Directory "[pathToSource/perl_shop/src">
    AddHandler cgi-script .pl .pm
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch -Indexes
</Directory>
```
