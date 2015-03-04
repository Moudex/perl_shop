#!/usr/bin/env perl

package Commande;
use strict;

# Constructeur
sub new {
    my ($classe, $id, $client, $dateC, $dateE, $dateP) = @_;
    my $this = {
	"id" => $id,		# Id
	"client" => $client,	# Num client
	"dateC" => $dateC,	# Date de la commande
	"dateE" => $dateE,	# Date d'envoi
	"dateP" => $dateP	# Date de paiement
    };
    bless($this, $classe);
    return $this;
}

# Charge la commande depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre la commande en BDD
sub store {
    my ($this) = @_;

    # TODO Liaison avec la BDD
}

# Supprime la commande de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liasion avec la BDD
    # Supprimmer également tous les produits commandés
}

1;
