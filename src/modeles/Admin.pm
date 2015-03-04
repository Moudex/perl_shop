#!/usr/bin/env perl

package Admin;
use strict;
use Individu;
our @ISA = ("Individu");

# Constructeur
sub new {
    my ($classe, $id, $nom, $prenom, $email, $password, $role) = @_;
    my $this = SUPER::newfull($id, $nom, $prenom, $email, $password);
    $this->{role} = $role;
    bless($this, $classe);
    return $this;
}

# Charge l'admin depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }
    
    # TODO Liaison avec la bdd
}

# Enregistre l'admin en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

# Supprime l'admin de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

1;
