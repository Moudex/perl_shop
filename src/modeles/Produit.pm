#!/usr/bin/env perl

package Produit;
use strict;

# Constructeur unique
sub new {
    my($class, $id, $nom, $desc, $cat, $prix, $photo) = @_;
    my $this = {
	"id" => $id,	    # Id
	"nom" => $nom,	    # Nom
	"desc" => $desc,    # Description
	"cat" => $cat,	    # Catégorie
	"prix" => $prix,    # Prix
	"photo" => $photo   # Uri photo
    };
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"produits" => []    # Tableau d'objets Produit
    };
    bless($this, $class);
    return $this;
}

# Ajoute des produits à la liste
sub add {
    my $this = shift @_;
    if ($this->{produits} == undef) { die 'NotProduitList'; }
    else {
	foreach (@_) {
	    push @{$this->{produits}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{produits} == undef) {
	return "[Produit: $this->{id}, $this->{nom}, $this->{desc}, $this->{cat}, $this->{prix}, $this->{photo}]";
    } else {
	my $out = '[Produits: ';
	$out .= join(', ', map({$_->toString()} @{$this->{produits}}));
	return $out . ']';
    }
}

# Charge le produit depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre le ou les produit en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

# Supprime le produit de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

1;
