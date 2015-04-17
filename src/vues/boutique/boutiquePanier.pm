###
#   Panier
#
#   Affiche les produits du panier
###

package boutiquePanier;

use CGI qw/:standard/;

sub make {
    my ($class, $produits) = @_;
    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .= '<h3>Panier</h3>';

    $out .= '</div>';
    return $out;
}
 1;
