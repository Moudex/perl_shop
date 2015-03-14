#!/usr/bin/env perl

package Individu;
use strict;
use Modele;
use Connexion;

our $tableName = 'Individu';

# Constructeur
sub new {
    my $class = shift @_;
    my $size = $#_+1;
    my $this = {};
    bless($this, $class);
    if ($#_ > 1 ) {
	$this->{nom} = shift @_;	# Nom
	$this->{prenom} = shift @_;	# Prenom
	$this->{email} = shift @_;	# Email
	$this->{password} = shift @_;   # Password
    } else {
	$this->load(shift @_);
    }
    return $this;
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    return "[Individu: $this->{id}, $this->{nom}, $this->{prenom}, $this->{email}]";
}

# Charge l'individu depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq undef) {
	die 'UndefinedId';
	return -1;
    }
    my $res = Modele->load($tableName, $id);
    $this->{id} = @$res[0];
    $this->{nom} = @$res[1];
    $this->{prenom} = @$res[2];
    $this->{email} = @$res[3];
    $this->{password} = @$res[4];
}

# Enregistre l'individu en BDD
sub store {
    my ($this) = @_;
    my $dbh = Connexion->getDBH();
    my $sf_tn = $dbh->quote_identifier($tableName);
    my $sth;
    if ($this->{id} eq undef) { # Création
	$this->{id} = Modele->nextId($tableName);
	$sth = $dbh->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?,?)");
	$sth->execute($this->{id}, $this->{nom}, $this->{prenom}, $this->{email}, $this->{password});
    } else { # Modification
	$sth = $dbh->prepare("UPDATE $sf_tn SET Nom=?, Prenom=?, Email=?, Password=? WHERE Id=?");
	$sth->execute($this->{nom}, $this->{prenom}, $this->{email}, $this->{password}, $this->{id});
    }
    $sth->finish();
    $dbh->commit();
}


###
#   Méthodes de classe
###

# Supprime l'individu de la BDD
sub remove {
    my ($class, $id) = @_;
    Modele->remove($tableName, $id);
}

# Crée la table
sub createTable {
    Modele->dropTable($tableName);
    my $dbh = Connexion->getDBH();
    my $sf_tn = $dbh->quote_identifier($tableName);
    my $sth = $dbh->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Nom text NOT NULL, Prenom text NOT NULL, Email text NOT NULL, Password text NOT NULL)");
    $sth->execute();
    $sth->finish();
    $dbh->commit();
}

# Supprime la table
sub dropTable {
    Modele->dropTable($tableName);
}

1;
