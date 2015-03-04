#!/usr/bin/env perl

package Categorie;
use strict;

sub newfull {
    my ($classe, $nom) = @_;
    my $this = {
	"id" => -1,
	"nom" => $nom
    };
    bless($this, $classe);
    return $this;
}

sub newid {
    my ($classe, $id) = @_;
    my $this = {
	"id" => $id,
	"nom" => ""
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
