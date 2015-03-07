#!/usr/bin/env perl

package Categorie;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'Categorie';

# Constructeur unique
sub new {
    my ($class, $id, $nom) = @_;
    my $this = $class->Modele::new();
    $this->{id} = $id;	    # Id
    $this->{nom} = $nom;    # Nom de la catégorie
    bless($this, $class);
    if ($id ne "") { $this->load($id); }
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
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{nom} = @$res[1];
}

# Enregistre la ou les catégorie en BDD
sub store {
    my ($this) = @_;
    if ($this->{categories} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq "") { # Création
	    $this->{id} = $this->nextId($tableName);
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?)");
	    $sth->execute($this->{id}, $this->{nom});
	} else { # Modification
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Nom=? WHERE Id=?");
	    $sth->execute($this->{nom}, $this->{id});
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
    if ($this->{id} eq "") {
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
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Nom text NOT NULL)");
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
