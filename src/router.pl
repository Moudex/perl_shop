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
my $path = $ENV{'REQUEST_URI'};
$path =~ s/^\/perlshop//; #On enlève le prefixe

if($path =~ s!^/stock!!) {
    stock();
} else {
    boutique();
}

sub boutique {
    my $c = BoutiqueController->new(@values);

    # Page d'index
    if ($path =~ m!^/?$!) { $c->indexAction(); }

    # Parcour d'une catégorie
    elsif ($path =~ m!^/categorie/([a-z]+|\d+)/?!) { $c->categorieAction($1); }

    # Visualisation d'un produit
    elsif ($path =~ m!^/produit/(\d)/?!) { $c->produitAction($1); }

    # Visualisation du panier
    elsif ($path =~ m!^/panier/?!) { $c->panierAction(); }

    # Page introuvable
    else { $c->notFound(); }
}

sub stock {
    my $c = StockController->new(@values);

    # Page d'index du stock
    if ($path =~ m!^/?$!) { $c->indexAction(); }

    # Détail d'une commande
    elsif ($path =~ m!^/commande/(\d)/?!) { $c->commandeAction($1); }

    # Liste des prochaines commandes
    elsif ($path =~ m!^/commande/?!) { $c->commandesAction(); }

    # Page introuvable
    else { $c->notFound(); }
}
