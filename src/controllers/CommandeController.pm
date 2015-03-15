package CommandeController;

###
#   Route: /commande
###

use strict;
use Controller;

our @ISA = ("Controller");

# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('Commande', $form);
    bless($this, $class);
    return $this;
}

## Subroute: /
## Subroute: /page/{page}
sub indexAction {
    # restriction admin
    # Afficher les commandes en attentes paginé
}

## Subroute: /new
sub newAction {

}

## Subroute: /panier
sub panierAction {

}

1;
