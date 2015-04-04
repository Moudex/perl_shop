package CategorieController;

###
#   Route: /categorie
###

use strict;
use Controller;
use boutiqueLayout;
use boutiqueGListe;
use boutiquePListe;
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
    # TODO appeller en bdd avec le nom de la categorie et non l'id
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
    my ($this, $cat) = @_;
    # Récupérer les produits de la catégorie
    # Les trier selon plusieurs critères
    # Paginer le résultat
    my $prods = Produit->load_from_cat($cat);
    my $content = boutiquePListe->make($prods);
    $this->render($content);
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
