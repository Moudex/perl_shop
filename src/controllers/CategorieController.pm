package CategorieController;

###
#   Route: /categorie
###

use strict;
use Controller;
use boutiqueLayout;
use boutiqueGListe;
use Categorie;
use Produit;

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
    my ($this) = @_;
    # On récupère les produits en BDD
    my $destockage = Produit->load_from_cat(0);
    # On les mets dans la vue
    my $content = boutiqueGListe->make($destockage);
    $this->render($content);
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
