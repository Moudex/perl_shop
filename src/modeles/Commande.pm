#!/usr/bin/env perl

package Commande;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'Commande';

# Constructeur unique
sub new {
    my ($class, $id, $client, $dateC, $dateE, $dateP) = @_;
    my $this = $class->Modele::new();
    $this->{id} = $id;		# Id
    $this->{client} = $client;	# Num client
    $this->{dateC} = $dateC;	# Date de la commande
    $this->{dateE} = $dateE;	# Date d'envoi
    $this->{dateP} = $dateP;	# Date de paiement
    bless($this, $class);
    if ($id ne "") { $this->load($id); }
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"commandes" => []	# Tableau d'objets Commande
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

# Ajoute des commandes à la liste
sub add {
    my $this = shift @_;
    if ($this->{commandes} == undef) { die 'NotCommandeList'; }
    else {
	foreach (@_) {
	    push @{$this->{commandes}}, $_;
	}
    }
}

# Représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{commandes} == undef) {
	return "[Commande: $this->{id}, $this->{client}, $this->{dateC}, $this->{dateE}, $this->{dateP}]";
    } else {
	my $out = '[Commandes: ';
	$out .= join(', ', map({$_->toString()} @{$this->{commandes}}));
	return $out . ']';
    }
}

# Charge la commande depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
	return -1;
    }
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{client} = @$res[1];
    $this->{dateC} = @$res[2];
    $this->{dateE} = @$res[3];
    $this->{dateP} = @$res[4];
}

# Enregistre la ou les commande en BDD
sub store {
    my ($this) = @_;
    if ($this->{commandes} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq "") { # Création
	    $this->{id} = $this->nextId($tableName);
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?,?)");
	    $sth->execute($this->{id}, $this->{client}, $this->{dateC}, $this->{dateE}, $this->{dateP});
	} else { # Modification
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Client=?, DateC=?, DateE=?, DateP=? WHERE Id=?");
	    $sth->execute($this->{client}, $this->{dateC}, $this->{dateE}, $this->{dateP}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	return -1;
    }
}

# Supprime la commande de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liasion avec la BDD
    # Supprimmer également tous les produits commandés
}

# Crée la table
sub createTable {
    my ($class) = @_;
    my $mod = Modele->new();
    my $sf_tn = $mod->{dbh}->quote_identifier($tableName);
    $mod->dropTable($tableName);
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Client integer NOT NULL, DateC date NOT NULL, DateE date, DateP date)");
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
