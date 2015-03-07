#!/usr/bin/env perl

use strict;

use lib ("../src/modeles");
use Individu;
use Client;
use Commande;

Individu->createTable();
Client->createTable();
Commande->createTable();

print "\n### CLIENTS ###\n";
my $cli0 = Client->new("", 'John', 'Doe', 'john.doe@email.com', 'pass', 'Dijon', '15/05/1658', 'Mr');
print $cli0->toString() ."\n";
$cli0->store();
my $cli1 = Client->new(0);
$cli1->{nom} = 'Chuck';
$cli1->store();
my $cli2 = Client->new(0);
print $cli2->toString() ."\n";

print "\n### COMMANDES ###\n";
my $com0 = Commande->new("", 0, '15/02/2015', '17/02/2015');
print $com0->toString() ."\n";
$com0->store();
my $com1 = Commande->new(0);
$com1->{dateP} = '15/02/2015';
$com1->store();
my $com2 = Commande->new(0);
print $com2->toString() ."\n";
