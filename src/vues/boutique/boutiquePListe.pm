######
#   Petite Liste
#
#   Ce fichier fait une liste de certains produits.
#   Grande image, petite description
#####

package boutiquePListe;

use CGI qw/:standard/;


sub make {
    my ($class, $produits) = @_;
    return $produits->toString();
}

1;
