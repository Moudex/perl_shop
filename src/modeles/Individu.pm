#!/usr/bin/env perl

# Classe abstraite

package Individu;
use strict;

sub newfull {
    my($classe, $nom, $prenom, $email, $password) = @_;
    my $this = {
	"id" => -1,
	"nom" => $nom,
	"prenom" => $prenom,
	"email" => $email,
	"password" => $password
    };
    bless($this, $classe);
    return $this;
}

sub newid {
    my($classe, $id) = @_;
    my $this = {
	"id" => $id,
	"nom" => "",
	"prenom" => "",
	"email" => "",
	"password" => ""
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
