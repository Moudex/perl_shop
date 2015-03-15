package CategorieController;

###
#   Route: /categorie
###

use strict;
use Controller;

our @ISA = ("Controller");

# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Categorie', $form);
    bless($this, $class);
    return $this;
}

## Subroute: /
sub indexAction {
    # Afficher produits destockage grands items
}

## Subroute: /{catId}
## Subroute: /{nomCat}
sub voirAction {
    # Récupérer les produits de la catégorie
    # Les trier selon plusieurs critères
    # Paginer le résultat
}

###
#   Restriction ADMIN
###

## Subroute: /new
sub newAction {
    # Restriction Admin
    # formulaire Catégorie
}

## Subroute: /edit/{catId}
## Subroute: /edit/{nomCat}
sub editAction {
    # Restriction Admin
    # formulaire Catégorie
}

## Subroute: /delete/{catId}
## Subroute: /delete/{nomCat}
sub deleteAction {
    # Restriction Admin
}

1;
