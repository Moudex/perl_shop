#!/usr/bin/env perl

package Categorie;
use strict;

# Constructeur
sub new {
    my ($classe, $id, $nom) = @_;
    my $this = {
	"id" => $id,
	"nom" => $nom
    };
    bless($this, $classe);
    return $this;
}

# Charge la catégorie depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Enregistre la catégorie en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

# Supprime la catégorie de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

1;
