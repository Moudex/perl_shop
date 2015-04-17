######
#   Liste des commandes
#
#   Ce fichier liste les commandes
######

package stockCommandes;

use CGI qw/:standard/;

sub make {
    my ($class, $commandes) = @_;

    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .= '<h3>Liste des commandes</h3>';
    $out .= $commandes->toString();
    $out .= '</div>';

    return $out;
}

1;
