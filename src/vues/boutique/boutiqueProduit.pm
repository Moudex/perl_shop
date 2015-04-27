#####
#   Produit
#
#   Visualisation d'un produit
#####

package boutiqueProduit;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, $produit) = @_;
    my $out = '<div>';
    $out .= '<h3>Visualisation produit</h3>';
    $out .= $produit->toString();
    $out .= '</div>';
    return $out;
}

1;
