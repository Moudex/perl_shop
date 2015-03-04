#!/usr/bin/env perl

package ProdCom;
use strict;

# Constructeur
sub new {
    my ($classe, $id, $produit, $commande, $quantitee) = @_;
    my $this = {
	"id" => $id,		    # Id
	"produit" => $produit,	    # Num produit
	"commande" => $commande,    # Num commande
	"quantitee" => $quantitee   # Quantitée
    };
    bless($this, $classe);
    return $this;
}

# Charge le produit commandé depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre le produit commandé en BDD
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
