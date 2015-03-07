#!/usr/bin/env perl

package Modele;
use DBI;
use strict;

# Constructeur
sub new {
    my ($class) = @_;
    my $dsn = "DBI:SQLite:dbname=perlshop.db";
    my $dbh =  DBI->connect($dsn,"","",{ RaiseError => 1 },) or die $DBI::errstr;
    $dbh->{AutoCommit} = 0;
    my $this = {
	"dsn" => $dsn,
	"dbh" => $dbh
    };
    bless($this, $class);
    return $this;
}

# Destructeur
sub DESTROY {
    my ($this) = @_;
    $this->{dbh}->disconnect();
}

# Récupère un objet
sub getOne {
    my ($this, $tableName, $id) = @_;
    my $sf_tn = $this->{dbh}->quote_identifier($tableName);
    my $sth = $this->{dbh}->prepare("SELECT * FROM $sf_tn WHERE Id = ?");
    $sth->execute($id);
    my $res = $sth->fetchrow_arrayref();
    $sth->finish();
    $this->{dbh}->commit();
    return $res;
}

# Supression de table
sub dropTable {
    my ($this, $tableName) = @_;
    my $sf_tn = $this->{dbh}->quote_identifier($tableName);
    my $sth = $this->{dbh}->prepare("DROP TABLE IF EXISTS $sf_tn");
    $sth->execute();
    $sth->finish();
    $this->{dbh}->commit();
}

# Génère un id
sub nextId {
    my ($this, $tableName) = @_;
    my $sf_tn = $this->{dbh}->quote_identifier($tableName);
    my $sth = $this->{dbh}->prepare("SELECT max(Id) FROM $sf_tn");
    $sth->execute();
    my $res = $sth->fetchrow_arrayref();
    $sth->finish();
    $this->{dbh}->commit();
    if (@$res[0] == "") {
	return 0;
    } else {
	return @$res[0];
    }
}

1;
