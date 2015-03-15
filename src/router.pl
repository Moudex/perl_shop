#!/usr/bin/env perl

use CGI;

# Récupération des paramètres
my $buffer = new CGI;
my @values = $buffer->param;

# URI de la requète
my $URI = $ENV{'REQUEST_URI'};


