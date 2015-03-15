package UserController;

###
#   Route: /user
###

use strict;
use Controller;

our @ISA = ("Controller");

# Constructeur
sub new {
    my ($class, $form) = @_;
    my $this = Controller::new('User', $form);
    bless($this, $class);
    return $this;
}

## Subroute: /
sub indexAction {

}

## Subroute: /{id}
sub voirAction {
    # Restriction propriétaire ou admin
    # afficher profil
}

## Subroute: /edit/{id}
sub editAction {
    # restriction propriétaire ou admin
    # formulaire user
}

## Subroute: /delete/{id}
sub deleteAction {
    # restriction propriétaire ou admin
}

## Route: /login
sub loginAction {

}

## Route: /signin
sub signinAction {

}

## Route: /logout
sub logoutAction {

}

1;
