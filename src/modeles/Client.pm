#!/usr/bin/env perl

package Client;
use strict;
use Modele;
use Individu;
our @ISA = ("Individu");

our $tableName = 'Client';

# Constructeur unique
sub new {
    my ($class, $id, $nom, $prenom, $email, $password, $adresse, $datenaiss, $civi) = @_;
    my $this = $class->Individu::new($id, $nom, $prenom, $email, $password);
    $this->{adresse} = $adresse;	# Adresse
    $this->{datenaiss} = $datenaiss;	# Date de naissance
    $this->{civi} = $civi;		# Civilitée
    bless($this, $class);
    if ($id ne "") { $this->load($id); }
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"clients" => []
    };
    bless($this, $class);
    $this->add(@_);
    return $this;
}

# Destructeur
sub DESTROY {
    my ($this) = @_;
    $this->Individu::DESTROY();
}

# Ajoute des clients à la liste
sub add {
    my $this = shift @_;
    if ($this->{clients} == undef) { die 'NotClientList'; }
    else {
	foreach (@_) {
	    push @{$this->{clients}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{clients} == undef) {
	return "[Client: ".$this->SUPER::toString().", $this->{adresse}, $this->{datenaiss}, $this->{civi}]";
    } else {
	my $out = '[Clients: ';
	$out .= join(', ', map({$_->toString()} @{$this->{clients}}));
	return $out .']';
    }
}

# Charge le client depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
	return -1;
    }
    $this->Individu::load($id);
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{adresse} = @$res[1];
    $this->{datenaiss} = @$res[2];
    $this->{civi} = @$res[3];
}

# Enregistre du ou des client en BDD
sub store {
    my ($this) = @_;
    if ($this->{clients} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq "") { # Création
	    $this->Individu::store();
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?)");
	    $sth->execute($this->{id}, $this->{adresse}, $this->{datenaiss}, $this->{civi});
	} else { # Modification
	    $this->Individu::store();
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Adresse=?, DateNaiss=?, Civi=? WHERE Id=?");
	    $sth->execute($this->{adresse}, $this->{datenaiss}, $this->{civi}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	# Pas encore implémenté !
	return -1;
    }
}

# Supprime le client de la BDD
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
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Adresse text NOT NULL, DateNaiss date NOT NULL, Civi text NOT NULL)");
    $sth->execute();
    $sth->finish();
    $mod->{dbh}->commit();
}

sub dropTable {
    my ($class) = @_;
    my $mod = Modele->new();
    $mod->dropTable($tableName);
}

1;
