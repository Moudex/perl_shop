#####
#   Produit
#
#   Visualisation d'un produit
#####

package bouotiqueProduit;

use CGI qw/:standard/;

sub make {
    my ($class, $produit) = @_;
    return $produit->toString();
}

1;
