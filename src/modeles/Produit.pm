#!/usr/bin/env perl

package Produit;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'Produit';

# Constructeur unique
sub new {
    my $class = shift @_;
    my $size = $#_+1;
    my $this = $class->Modele::new();
    bless($this, $class);
    if ($size > 1) {
	$this->{nom} = shift @_;    # Nom
	$this->{desc} = shift @_;   # Description
	$this->{cat} = shift @_;    # Catégorie
	$this->{prix} = shift @_;   # Prix
	$this->{photo} = shift @_;  # Uri photo
    } else {
	$this->load(shift @_);
    }
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"produits" => []    # Tableau d'objets Produit
    };
    bless($this, $class);
    return $this;
}

# Destructeur
sub DESTROY {
    my ($this) =@_;
    $this->Modele::DESTROY();
}

# Ajoute des produits à la liste
sub add {
    my $this = shift @_;
    if ($this->{produits} == undef) { die 'NotProduitList'; }
    else {
	foreach (@_) {
	    push @{$this->{produits}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{produits} == undef) {
	return "[Produit: $this->{id}, $this->{nom}, $this->{desc}, $this->{cat}, $this->{prix}, $this->{photo}]";
    } else {
	my $out = '[Produits: ';
	$out .= join(', ', map({$_->toString()} @{$this->{produits}}));
	return $out . ']';
    }
}

# Charge le produit depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq undef) {
	die 'UndefinedId';
    }
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{nom} = @$res[1];
    $this->{desc} = @$res[2];
    $this->{cat} = @$res[3];
    $this->{prix} = @$res[4];
    $this->{photo} = @$res[5];
}

# Enregistre le ou les produit en BDD
sub store {
    my ($this) = @_;
    if ($this->{produits} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq undef) { # Création
	    $this->{id} = $this->nextId($tableName);
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?,?,?)");
	    $sth->execute($this->{id}, $this->{nom}, $this->{desc}, $this->{cat}, $this->{prix}, $this->{photo});
	} else { # Modification
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Nom=?, Desc=?, Cat=?, Prix=?, Photo=? WHERE Id=?");
	    $sth->execute($this->{nom}, $this->{desc}, $this->{cat}, $this->{prix}, $this->{photo}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	return -1;
    }
}

# Supprime le produit de la BDD
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
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Nom text NOT NULL, Desc text, Cat integer NOT NULL, Prix real NOT NULL, Photo text, FOREIGN KEY(Cat) REFERENCES Categorie(Id))");
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
