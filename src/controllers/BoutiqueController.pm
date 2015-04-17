package BoutiqueController;

###
#   Controlleur de la boutique
#   S'occupe de toute la partie publique de la boutique
###

use strict;

# Modèles
use Categorie;
use Produit;

# vues
use boutiqueLayout;
use boutiqueGListe;
use boutiquePListe;
use boutiqueProduit;
use boutiquePanier;

# Controlleur
use Controller;
our @ISA = ("Controller");


# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Boutique', $form);
    bless($this, $class);
    return $this;
}

# Méthode de rendu
sub render {
    # Insertion du contenu
    # Ajout de la barre de navigation contenant les catégories
    # Appel de la méthode render générale
    my ($this, $content) = @_;
    my @cats = Categorie->getCategories();
    my $out = boutiqueLayout->make($content, @cats);
    $this->Controller::render($out);
}

# Index principal
# Subroute: /
sub indexAction {
    # Récupération des produits en destockage
    # Les places dans une vue "gros items"
    my ($this) =@_;
    my $destockage = Produit->load_from_cat(0);
    my $content = boutiqueGListe->make($destockage);
    $this->render($content);
}

# Liste des produits d'une catégorie
# Subroute: /categorie/{catId}
# Subroute: /categorie/{nomCat}
sub categorieAction {
    # Récupération des produit de la catégorie
    # Les place dans une vue "petits items"
    my ($this, $cat) = @_;
    my $prods = Produit->load_from_cat($cat);
    my $content = boutiquePListe->make($prods);
    $this->render($content);
}

# Affiche complètement un produit
# Subroute: /produit/{prodId}
sub produitAction {
    # Récupère le produit en BDD
    # L'affiche seul sur une page
    my ($this, $prodId) = @_;
    my $prod = Produit->new($prodId);
    my $content = boutiqueProduit->make($prod);
    $this->render($content);
}

# Affiche le panier
# Subroute: /panier
sub panierAction {
    my ($this) = @_;
    # TODO récupérer les produits commandés
    my $content = boutiquePanier->make();
    $this->render($content);
}


1;
