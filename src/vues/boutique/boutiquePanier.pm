###
#   Panier
#
#   Affiche les produits du panier
###

package boutiquePanier;

use CGI qw/:standard/;

sub make {
    my ($class, $produits) = @_;
    my $out = '<div>';

    $out .= '<h3>Panier</h3>';

    $out .= '</div>';
    return $out;
}
 1;
