#####
#   Produit
#
#   Visualisation d'un produit
#####

package boutiqueProduit;

use CGI qw/:standard/;

sub make {
    my ($class, $produit) = @_;
    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';
    $out .= '<h3>Visualisation produit</h3>';
    $out .= $produit->toString();
    $out .= '</div>';
    return $out;
}

1;
