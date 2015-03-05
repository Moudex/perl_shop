#!/usr/bin/env perl

package Categorie;
use strict;

# Constructeur unique
sub new {
    my ($class, $id, $nom) = @_;
    my $this = {
	"id" => $id,	# Id
	"nom" => $nom	# Nom de la catégorie
    };
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"cats" => []	# Tableau d'objets Categorie
    };
    bless($this, $class);
    $this->add(@_);
    return $this;
}

# Ajoute des catégories à la liste
sub add {
    my $this = shift @_;
    if ($this->{cats} == undef) { die 'NotCategorieList'; }
    else {
	foreach (@_) {
	    push @{$this->{cats}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{cats} == undef) {
	return "[Categorie: $this->{id}, $this->{nom}]";
    } else {
	my $out = '[Categories: ';
	$out .= join(', ', map({$_->toString()} @{$this->{cats}}));
	return $out . ']';
    }
}

# Charge la catégorie depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Enregistre la ou les catégorie en BDD
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
