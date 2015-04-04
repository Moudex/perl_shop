#!/usr/bin/env perl

use CGI;
use lib ("controllers");
use lib ("modeles");
use lib ("vues");
use lib ("vues/boutique");
use Controller;
use CategorieController;
use ProduitController;

# Récupération des paramètres
my $buffer = new CGI;
my @values = $buffer->param;

# URI de la requète
my $URI = $ENV{'REQUEST_URI'};
$URI =~ s/^\/perlshop//; #On enlève le prefixe

if ($URI =~ s!^/$!!) {
    # Page d'index
    CategorieController->new(@values)->indexAction();
}
elsif ($URI =~ s!^/categorie/([a-z]+|\d+)!!) {
    # Parcour d'une catégorie
    CategorieController->new(@values)->voirAction($1);
}
elsif ($URI =~ s!^/produit/(\d)!!) {
    # Visualisation d'un produit
    ProduitController->new(@values)->voirAction($1);
} else {
    # Page d'erreur 404
    Controller->new('Erreur 404', @values)->notFound();
}

