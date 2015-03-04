#!/usr/bin/env perl

# Classe abstraite

package Individu;
use strict;

# Constructeur
sub newfull {
    my($classe, $id, $nom, $prenom, $email, $password) = @_;
    my $this = {
	"id" => $id,		    # Id
	"nom" => $nom,		    # Nom
	"prenom" => $prenom,	    # Prenom
	"email" => $email,	    # Email
	"password" => $password	    # Password
    };
    bless($this, $classe);
    return $this;
}

# Charge l'individu depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Enregistre l'individu en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}


# Supprime l'individu de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }
    
    # TODO Liaison avec la bdd
    # Supprimer également le client ou admin, commandes, et produits commandés
}

1;
