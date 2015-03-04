#!/usr/bin/env perl

package Produit;
use strict;

# Constructeur
sub new {
    my($classe, $id, $nom, $desc, $cat, $prix, $photo) = @_;
    my $this = {
	"id" => $id,	    # Id
	"nom" => $nom,	    # Nom
	"desc" => $desc,    # Description
	"cat" => $cat,	    # Catégorie
	"prix" => $prix,    # Prix
	"photo" => $photo   # Uri photo
    };
    bless($this, $classe);
    return $this;
}

# Charge le produit depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre le produit en BDD
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
