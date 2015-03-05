#!/usr/bin/env perl

package ProdCom;
use strict;

# Constructeur unique
sub new {
    my ($class, $id, $produit, $commande, $quantitee) = @_;
    my $this = {
	"id" => $id,		    # Id
	"produit" => $produit,	    # Num produit
	"commande" => $commande,    # Num commande
	"quantitee" => $quantitee   # Quantitée
    };
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my ($class) = @_;
    my $this = {
	"prodsComs" => []    # Tableau de produits commandés
    };
    bless($this, $class);
    return $this;
}

# Ajoute un produit commandé à la liste
sub add {
    my ($this) =shift @_;
    if ($this->{prodsComs} == undef) { die 'NotProdComList'; }
    else {
	foreach (@_) {
	    push @{$this->{prodsComs}}, $_;
	}
    }
}

# représentation textuelle
sub toString {
    my ($this) =@_;
    if ($this->{prodsComs} == undef) {
	return "[ProduitCommande: $this->{id}, $this->{produit}, $this->{commande}, $this->{quantitee}]";
    } else {
	my $out = '[ProduitsCommandes: ';
	$out .= join(', ', map({$_->toString()} @{$this->{prodsComs}}));
	return $out . ']';
    }
}

# Charge le produit commandé depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre le ou les produit commandé en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la BDD
}

# Supprime le produit commandé de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

1;
