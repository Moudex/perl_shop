#!/usr/bin/env perl

package Admin;
use strict;
use Individu;
our @ISA = ("Individu");

sub newfull {
    my ($classe, $nom, $prenom, $email, $password, $role) = @_;
    my $this = SUPER::newfull($nom, $prenom, $email, $password);
    $this->{role} = $role;
    bless($this, $classe);
    return $this;
}

sub newid {
    my ($classe, $id) = @_;
    my $this = SUPER::newid($id);
    $this->load($id);
    bless($this, $classe);
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
