#!/usr/bin/env perl

package Client;
use strict;
use Individu;
our @ISA = ("Individu");

# Constructeur unique
sub new {
    my ($class, $id, $nom, $prenom, $email, $password, $adresse, $datenaiss, $civi) = @_;
    my $this = $class->SUPER::new($id, $nom, $prenom, $email, $password);
    $this->{adresse} = $adresse;	# Adresse
    $this->{datenaiss} = $datenaiss;	# Date de naissance
    $this->{civi} = $civi;		# Civilitée
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"clients" => []
    };
    bless($this, $class);
    $this->add(@_);
    return $this;
}

# Ajoute des clients à la liste
sub add {
    my $this = shift @_;
    if ($this->{clients} == undef) { die 'NotClientList'; }
    else {
	foreach (@_) {
	    push @{$this->{clients}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{clients} == undef) {
	return "[Client: ".$this->SUPER::toString().", $this->{adresse}, $this->{datenaiss}, $this->{civi}]";
    } else {
	my $out = '[Clients: ';
	$out .= join(', ', map({$_->toString()} @{$this->{clients}}));
	return $out .']';
    }
}

# Charge le client depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Enregistre du ou des client en BDD
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
