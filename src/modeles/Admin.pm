#!/usr/bin/env perl

package Admin;
use strict;
use Modele;
use Individu;
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
    my $res = $this->Modele::getOne($tableName, $id);
    $this->{id} = @$res[0];
    $this->{role} = @$res[1];
}

# Enregistre le ou les admin en BDD
sub store {
    my ($this) = @_;
    if ($this->{admins} == undef) {
	my $sf_tn = $this->{dbh}->quote_identifier($tableName);
	my $sth;
	if ($this->{id} eq undef) { # Création
	    $this->Individu::store();
	    $sth = $this->{dbh}->prepare("INSERT INTO $sf_tn VALUES (?,?)");
	    $sth->execute($this->{id}, $this->{role});
	} else { # Modification
	    $this->Individu::store();
	    $sth = $this->{dbh}->prepare("UPDATE $sf_tn SET Role=? WHERE Id=?");
	    $sth->execute($this->{role}, $this->{id});
	}
	$sth->finish();
	$this->{dbh}->commit();
    } else {
	# Pas encore implémenté !
	return -1;
    }
}

# Supprime l'admin de la BDD
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
    my $sth = $mod->{dbh}->prepare("CREATE TABLE $sf_tn (Id integer PRIMARY KEY, Role text NOT NULL)");
    $sth->execute();
    $sth->finish();
    $mod->{dbh}->commit();
}

# Supression de la table
sub dropTable {
    my ($class) = @_;
    my $mod = Modele->new();
    $mod->dropTable($tableName);
}

1;
