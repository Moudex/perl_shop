#!/usr/bin/env perl

package Admin;
use strict;
use Modele;
use Individu;
use Connexion;
our @ISA = ("Individu");

our $tableName = 'Admin';

# Constructeur unique
sub new {
    my $class = shift @_;
    my $size = $#_+1;
    my $this = $class->Individu::new(@_);
    bless($this, $class);
    if ($size > 1) {
	for(my $i=0; $i<4; $i++) { shift @_; }
	$this->{role} = shift @_;  # Role de l'administrateur
    } else {
	$this->load(shift @_);
    }
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

# Destructeur
sub DESTROY {
    my ($this) = @_;
    $this->Individu::DESTROY();
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
    if ($id eq undef) {
	die 'UndefinedId';
	return -1;
    }
    $this->Individu::load($id);
    my $res = Modele->load($tableName, $id);
    $this->{id} = @$res[0];
    $this->{role} = @$res[1];
}

# Enregistre le ou les admin en BDD
sub store {
    my ($this) = @_;
    if ($this->{admins} == undef) {
	my $dbh = Connexion->getDBH();
	my $sf_tn = $dbh->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq undef) { # Création
	    $this->Individu::store();
	    $sth = $dbh->prepare("INSERT INTO $sf_tn VALUES (?,?)");
	    $sth->execute($this->{id}, $this->{role});
	} else { # Modification
	    $this->Individu::store();
	    $sth = $dbh->prepare("UPDATE $sf_tn SET Role=? WHERE Id=?");
	    $sth->execute($this->{role}, $this->{id});
	}
	$sth->finish();
	$dbh->commit();
    } else {
	# Pas encore implémenté !
	return -1;
    }
}


###
#   Méthodes de classe
###

# Supprime l'admin de la BDD
sub remove {
    my ($class, $id) = @_;
    Modele->remove($tableName, $id);
    Individu->remove($id);
}

# Crée la table
sub createTable {
    Modele->dropTable($tableName);
    my $dbh = Connexion->getDBH();
    my $sf_tn = $dbh->quote_identifier($tableName);
    my $sth = $dbh->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Role text NOT NULL)");
    $sth->execute();
    $sth->finish();
    $dbh->commit();
}

# Supression de la table
sub dropTable {
    Modele->dropTable($tableName);
}

1;
