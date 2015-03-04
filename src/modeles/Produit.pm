#!/usr/bin/env perl

package Produit;
use strict;

sub newfull {
    my($classe, $nom, $desc, $cat, $prix, $photo) = @_;
    my $this = {
	"id" => -1,
	"nom" => $nom,
	"desc" => $desc,
	"cat" => $cat,
	"prix" => $prix,
	"photo" => $photo
    };
    bless($this, $classe);
    return $this;
}

sub newid {
    my($classe, $id) = @_;
    my $this = {
	"id" => $id,
	"nom" => "",
	"desc" => "",
	"cat" => -1,
	"prix" => "",
	"photo" => ""
    };
    bless($this, $classe);
    $this->load($id);
    return $this;
}

sub load {
    my ($this, $id) = @_;

    # TODO Liaison avec la bdd
}

sub store {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

sub delete {
    my ($this) = @_;

    # TODO Liaison avec la bdd
}

1;
