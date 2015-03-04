#!/usr/bin/env perl

package Client;
use strict;
use Individu;
our @ISA = ("Individu");

# Constructeur
sub new {
    my ($classe, $id, $nom, $prenom, $email, $password, $adresse, $datenaiss, $civi) = @_;
    my $this = SUPER::newfull($id, $nom, $prenom, $email, $password);
    $this->{adresse} = $adresse;	# Adresse
    $this->{datenaiss} = $datenaiss;	# Date de naissance
    $this->{civi} = $civi;		# Civilitée
    bless($this, $classe);
    return $this;
}

# Charge le client depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Enregistre le client en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

# Supprime le client de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

1;
