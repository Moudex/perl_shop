#!/usr/bin/env perl

use CGI;
use lib ("controllers");
use lib ("modeles");
use lib ("vues");
use lib ("vues/boutique");
use lib ("vues/stock");
use Controller;
use BoutiqueController;
use StockController;

# Récupération des paramètres
my $buffer = new CGI;
my @values = $buffer->param;

# URI de la requète
my $URI = $ENV{'REQUEST_URI'};
$URI =~ s/^\/perlshop//; #On enlève le prefixe

if ($URI =~ s!^/$!!) {
    # Page d'index
    BoutiqueController->new(@values)->indexAction();
}
elsif ($URI =~ s!^/categorie/([a-z]+|\d+)!!) {
    # Parcour d'une catégorie
    BoutiqueController->new(@values)->categorieAction($1);
}
elsif ($URI =~ s!^/produit/(\d)!!) {
    # Visualisation d'un produit
    BoutiqueController->new(@values)->produitAction($1);
}
elsif ($URI =~ s!^/panier/!!) {
    # Visualisation du panier
    BoutiqueController->new(@values)->panierAction();
}
elsif($URI =~ s!^/stock!!) {
    if ($URI =~ s!^/$!!) {
	# Page d'index stock
	StockController->new(@values)->indexAction();
    }
    elsif ($URI =~ s!^/commande/(\d)!!) {
	# Détail d'une commande
	StockController->new(@values)->commandeAction($1);
    }
    elsif ($URI =~ s!^/commande!!) {
	# Liste des prochainnes commandes
	StockController->new(@values)->commandesAction();
    }
    else {
	# Page d'erreur 404
	Controller->new('Erreur 404', @values)->notFound();
    }
} else {
    # Page d'erreur 404
    Controller->new('Erreur 404', @values)->notFound();
}

