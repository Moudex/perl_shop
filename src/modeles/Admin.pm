#!/usr/bin/env perl

package Admin;
use strict;
use Individu;
our @ISA = ("Individu");

# Constructeur unique
sub new {
    my ($class, $id, $nom, $prenom, $email, $password, $role) = @_;
    my $this = $class->SUPER::new($id, $nom, $prenom, $email, $password);
    $this->{role} = $role;  # Role de l'administrateur
    bless($this, $class);
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"admins" => []	    # Tableau d'objets Admin
    };
    bless($this, $class);
    $this->add(@_);
    return $this;
}

# Ajoute des admins à la liste
sub add {
    my $this = shift @_;
    if ($this->{admins} == undef) { die 'NotAdminList'; }
    else {
	foreach (@_) {
	    push @{$this->{admins}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{admins} == undef) {
	return "[Admin: ".$this->SUPER::toString().", $this->{role}]";
    } else {
	my $out = '[Admins: ';
	$out .= join(', ', map({$_->toString()} @{$this->{admins}}));
	return $out . ']';
    }
}

# Charge l'admin depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id == undef) {
	die 'UndefinedId';
    }
    
    # TODO Liaison avec la bdd
}

# Enregistre le ou les admin en BDD
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
