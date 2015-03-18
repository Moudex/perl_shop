#!/usr/bin/env perl

use CGI;
use lib ("controllers");
use lib ("modeles");
use lib ("vues");
use lib ("vues/boutique");
use CategorieController;

# Récupération des paramètres
my $buffer = new CGI;
my @values = $buffer->param;

# URI de la requète
my $URI = $ENV{'REQUEST_URI'};

CategorieController->new(@values)->render($URI);
