######
#   Grande Liste
#
#   Ce fichier fait une grande liste de produits sous forme de tableau
######

package boutiqueGListe;

use CGI qw/:standard/;

sub make {
    my ($class, $produits) = @_;
    return $produits->toString();
}
