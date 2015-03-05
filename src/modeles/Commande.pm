#!/usr/bin/env perl

package Commande;
use strict;

# Constructeur unique
sub new {
    my ($class, $id, $client, $dateC, $dateE, $dateP) = @_;
    my $this = {
	"id" => $id,		# Id
	"client" => $client,	# Num client
	"dateC" => $dateC,	# Date de la commande
	"dateE" => $dateE,	# Date d'envoi
	"dateP" => $dateP	# Date de paiement
    };
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"commandes" => []	# Tableau d'objets Commande
    };
    bless($this, $class);
    $this->add(@_);
    return $this;
}

# Ajoute des commandes à la liste
sub add {
    my $this = shift @_;
    if ($this->{commandes} == undef) { die 'NotCommandeList'; }
    else {
	foreach (@_) {
	    push @{$this->{commandes}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{commandes} == undef) {
	return "[Commande: $this->{id}, $this->{client}, $this->{dateC}, $this->{dateE}, $this->{dateP}]";
    } else {
	my $out = '[Commandes: ';
	$out .= join(', ', map({$_->toString()} @{$this->{commandes}}));
	return $out . ']';
    }
}

# Charge la commande depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Enregistre la ou les commande en BDD
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
