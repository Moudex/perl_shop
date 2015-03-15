package ProduitController;

###
#   Route: /produit
###

use strict;
use Controller;

our @ISA = ("Controller");

# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Produit', $form);
    bless($this, $class);
    return $this;
}

## Subroute: /
sub indexAction {
    # Rechercher les produits en destockage
    # Afficher liste grand items
}

## Subroute: /{id}
sub voirAction {
    # Recherche le produit
    # L'afficher en grand
}

###
#   Restriction ADMIN
###

## Subroute: /new
sub newAction {
    # Restriction Admin
    # formulaire produit
}

## Subroute: /edit/{id}
sub editAction {
    # Restriction Admin
    # formulaire produit
}

## Subroute: /delete/{id}
sub deleteAction {
    # Restriction Admin
}

1;
