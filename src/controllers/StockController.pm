package StockController;

###
#   Controller du stock
#   Gestion du stock, réappro, commandes
###

use strict;

# Modèles
use Produit;
use Commande;
use ProdCom;

# Vues
use stockLayout;
use stockCommandes;
use stockCommande;


# Controller
use Controller;
our @ISA = ("Controller");


# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Stocks', $form);
    bless($this, $class);
    return $this;
}

# Méthode de rendu
sub render {
    # Insertion du contenu
    # Barre de navigation admin
    # Appel d"e la méthode render générale
    my ($this, $content) = @_;
    # Layout Stock
    my $out = stockLayout->make($content);
    $this->Controller::render($out);
}

# Index Stock
# Subroute /stock/
sub indexAction {
    my ($this) = @_;
    my $content = '<p>Coucou !</p>';
    $this->render($content);
}

# Liste des commandes
# Subroute /stock/commande/
sub commandesAction {
    my ($this) = @_;
    # Récupère les commandes non traitées en BDD
    my $coms = Commande->get_no_spray();
    # Les affiches en liste
    my $out = stockCommandes->make($coms);
    $this->render($out);
}

# Détail commande
# Subroute /stock/commande/{comId}
sub commandeAction {
    my ($this, $idCom) = @_;
    my $prods = ProdCom->get_from_com($idCom);
    my $out = stockCommande->make($prods);
    $this->render($out);
}


# Approvisionne un produit
# Subroute /stock/produit/{prodId}
sub produitAction {

}

# Nouveau produit
# Subroute: /stock/produit/new
sub newProduitAction {
    my ($this) = @_;
    
}

# Retirer produit

1;
