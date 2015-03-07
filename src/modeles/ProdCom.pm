#!/usr/bin/env perl

package ProdCom;
use strict;
use Modele;
our @ISA = ("Modele");

our $tableName = 'ProdCom';

# Constructeur unique
sub new {
    my ($class, $id, $produit, $commande, $quantitee) = @_;
    my $this = $class->Modele::new();
    $this->{id} = $id;		    # Id
    $this->{produit} = $produit;    # Num produit
    $this->{commande} = $commande;  # Num commande
    $this->{quantitee} = $quantitee;# Quantitée
    bless($this, $class);
    if ($id ne "") { $this->load($id); }
    return $this;
}

# Constructeur multiple
sub many {
    my $class = shift @_;
    my $this = {
	"prodsComs" => []    # Tableau de produits commandés
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

# Ajoute des produits commandés à la liste
sub add {
    my $this = shift @_;
    if ($this->{prodsComs} == undef) { die 'NotProdComList'; }
    else {
	foreach (@_) {
	    push @{$this->{prodsComs}}, $_;
	}
    }
}

# représentation textuelle
sub toString {
    my ($this) = @_;
    if ($this->{prodsComs} == undef) {
	return "[ProduitCommande: $this->{id}, $this->{produit}, $this->{commande}, $this->{quantitee}]";
    } else {
	my $out = '[ProduitsCommandes: ';
	$out .= join(', ', map({$_->toString()} @{$this->{prodsComs}}));
	return $out . ']';
    }
}

# Charge le produit commandé depuis la BDD
sub load {
    my ($this, $id) = @_;
    if ($id eq "") {
	die 'UndefinedId';
    }
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{produit} = @$res[1];
    $this->{commande} = @$res[2];
    $this->{quantitee} = @$res[3];
}

# Enregistre le ou les produit commandé en BDD
sub store {
    my ($this) = @_;
    if ($this->{ProdsComs} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq "") { # Création
	    $this->{id} = $this->nextId($tableName);
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?,?,?)");
	    $sth->execute($this->{id}, $this->{produit}, $this->{commande}, $this->{quantitee});
	} else { # Modification
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Produit=?, Commande=?, Quantitee=? WHERE Id=?");
	    $sth->execute($this->{produit}, $this->{commande}, $this->{quantitee}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	return -1;
    }
}

# Supprime le produit commandé de la BDD
sub delete {
    my ($this) = @_;
    if ($this->{id} eq "") {
	die 'UndefinedId';
    }

    # TODO Liaison avec la BDD
}

# Crée la table
sub createTable {
    my ($class) = @_;
    my $mod = Modele->new();
    my $sf_tn = $mod->{dbh}->quote_identifier($tableName);
    $mod->dropTable($tableName);
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Produit inteeger NOT NULL, Commande integer NOT NULL, Quantitee integer default 1)");
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
