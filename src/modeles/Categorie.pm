#!/usr/bin/env perl

package Categorie;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'Categorie';

# Constructeur unique
sub new {
    my $class = shift @_;
    my $size = $#_+1;
    my $this = $class->Modele::new();
    bless($this, $class);
    if ($size > 1) {
	$this->{nom} = shift @_;    # Nom de la catégorie
	$this->{parent} = shift @_; # Catégorie père
    } else {
	$this->load(shift @_);
    }
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

# Destructeur
sub DESTROY {
    my ($this) = @_;
    $this->Modele::DESTROY();
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
	return "[Categorie: $this->{id}, $this->{nom}, $this->{parent}]";
    } else {
	my $out = '[Categories: ';
	$out .= join(', ', map({$_->toString()} @{$this->{cats}}));
	return $out . ']';
    }
}

# Charge la catégorie depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq undef) {
	die 'UndefinedId';
    }
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{nom} = @$res[1];
    $this->{parent} = @$res[2];
}

# Enregistre la ou les catégorie en BDD
sub store {
    my ($this) = @_;
    if ($this->{categories} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq undef) { # Création
	    $this->{id} = $this->nextId($tableName);
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?)");
	    $sth->execute($this->{id}, $this->{nom}, $this->{parent});
	} else { # Modification
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Nom=?, Parent=? WHERE Id=?");
	    $sth->execute($this->{nom}, $this->{parent}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	return -1;
    }
}

# Supprime la catégorie de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq undef) {
	die 'UndefinedId';
    }

    # TODO Liaison avec la bdd
}

# Crée la table
sub createTable {
    my ($class) = @_;
    my $mod = Modele->new();
    my $sf_tn = $mod->{dbh}->quote_identifier($tableName);
    $mod->dropTable($tableName);
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Nom text NOT NULL, Parent integer)");
    $sth->execute();
    $sth->finish();
    $mod->{dbh}->commit();
}

# Supprime la table
sub dropTable {
    my ($class) = @_;
    my $mod = Modele->new();
    $mod->dropTable($tableName);
}

1;
