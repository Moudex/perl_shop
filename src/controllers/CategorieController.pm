package CategorieController;

###
#   Route: /categorie
###

use strict;
use Controller;
use boutiqueLayout;
use Categorie;

our @ISA = ("Controller");

# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Categorie', $form);
    bless($this, $class);
    return $this;
}

sub render {
    my ($this, $content) = @_;
    
    # Récupération des catégories
    my @cats = Categorie->getCategories();
    
    # Appel du layout
    $this->Controller::render(boutiqueLayout->make($content, @cats));
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
