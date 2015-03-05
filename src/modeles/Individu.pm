#!/usr/bin/env perl

# Classe abstraite

package Individu;
use strict;

# Constructeur
sub new {
    my($class, $id, $nom, $prenom, $email, $password) = @_;
    my $this = {
	"id" => $id,		    # Id
	"nom" => $nom,		    # Nom
	"prenom" => $prenom,	    # Prenom
	"email" => $email,	    # Email
	"password" => $password	    # Password
    };
    bless($this, $class);
    return $this;
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    return "[Individu: $this->{id}, $this->{nom}, $this->{prenom}, $this->{email}]";
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
