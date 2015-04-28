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
use stockProduitForm;


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
    my $cgi = $this->{cgi};

    # Produit envoyé
    if ($this->sendProduit()) {
	my $prod = Produit->new($cgi->param('nom'), $cgi->param('desc'), $cgi->param('cat'), $cgi->param('prix'), $cgi->param('photo'), $cgi->param('qte'));
	my ($err, $mess) = $prod->check();
	if ($err == -1) {
	    $prod->store(); # Enregitrement
	    $this->redirect($this->path('produit/'.$prod->{id})); # Redirection
	} else {
	    # Si le produit n'est pas valide, on réafiche le formulaire pré-remplis
	    my %cats = Categorie->getCategoriesHash();
	    my $out = stockProduitForm->make(\%cats, $prod);
	    $this->render($out);
	}
    }

    # Nouveau produit
    else {
	my %cats = Categorie->getCategoriesHash();
	my $out = stockProduitForm->make(\%cats);
	$this->render($out);
    }
}

# Edition d'un produit
# Subroute: /stock/produit/edit/{prodId}
sub editProduitAction {
    my ($this, $id) = @_;
    my $cgi = $this->{cgi};

    # Produit envoyé
    if ($this->sendProduit()) {
	my $prod = Produit->new($cgi->param("nom"), $cgi->param("desc"), $cgi->param("cat"), $cgi->param("prix"), $cgi->param("photo"), $cgi->param("qte"));
	my ($err, $mess) = $prod->check();
	if ($err == -1) {
	    $prod->{id} = $id;
	    $prod->store(); # Enregitrement
	    $this->redirect($this->path('produit/'.$prod->{id})); # Redirection
	} else {
	    # Si le produit n'est pas valide, on réafiche le formulaire pré-remplis
	    my %cats = Categorie->getCategoriesHash();
	    my $out = stockProduitForm->make(\%cats, $prod);
	    $this->render($out);
	}
    }

    # Edition produit
    else {
	my $prod = Produit->new($id);
	my %cats = Categorie->getCategoriesHash();
	my $out = stockProduitForm->make(\%cats, $prod);
	$this->render($out);
    }
}

# Retirer produit


# Regarde si un produit à été envoyé
sub sendProduit {
    my ($this) = @_;
    my $cgi = $this->{cgi};

    return ($cgi->param("nom") ne undef) and ($cgi->param("desc") ne undef) and ($cgi->param("cat") ne undef) and ($cgi->param("prix") ne undef) and ($cgi->param("photo") ne undef) and ($cgi->param("qte") ne undef);
}


1;
