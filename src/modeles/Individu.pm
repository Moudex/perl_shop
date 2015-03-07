#!/usr/bin/env perl

package Individu;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'Individu';

# Constructeur
sub new {
    my($class, $id, $nom, $prenom, $email, $password) = @_;
    my $this = $class->Modele::new();
    $this->{id} = $id;		    # Id
    $this->{nom} = $nom;	    # Nom
    $this->{prenom} = $prenom;	    # Prenom
    $this->{email} = $email;	    # Email
    $this->{password} = $password;   # Password
    bless($this, $class);
    if ($id ne "") { $this->load($id); }
    return $this;
}

# Destructeur
sub DESTROY {
    my ($this) = @_;
    $this->Modele::DESTROY();
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    return "[Individu: $this->{id}, $this->{nom}, $this->{prenom}, $this->{email}]";
}

# Charge l'individu depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
	return -1;
    }
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{nom} = @$res[1];
    $this->{prenom} = @$res[2];
    $this->{email} = @$res[3];
    $this->{password} = @$res[4];
}

# Enregistre l'individu en BDD
sub store {
    my ($this) = @_;
    my $sf_tn = $this->{dbh}->quote_identifier($tableName);
    my $sth;
    if ($this->{id} eq "") { # Création
	$this->{id} = $this->nextId($tableName);
	$sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?,?)");
	$sth->execute($this->{id}, $this->{nom}, $this->{prenom}, $this->{email}, $this->{password});
    } else { # Modification
	$sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Nom=?, Prenom=?, Email=?, Password=? WHERE Id=?");
	$sth->execute($this->{nom}, $this->{prenom}, $this->{email}, $this->{password}, $this->{id});
    }
    $sth->finish();
    $this->{dbh}->commit();
}

# Supprime l'individu de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }
    
    # TODO Liaison avec la bdd
    # Supprimer également le client ou admin, commandes, et produits commandés
}

# Crée la table
sub createTable {
    my ($class) = @_;
    my $mod = Modele->new();
    my $sf_tn = $mod->{dbh}->quote_identifier($tableName);
    $mod->dropTable($tableName);
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Nom text NOT NULL, Prenom text NOT NULL, Email text NOT NULL, Password text NOT NULL)");
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
