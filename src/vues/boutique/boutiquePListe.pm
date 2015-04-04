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
    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .= '<h3>Petite liste de produits</h3>';
    $out .= $produits->toString();
    $out .= '</div>';

    return $out;
}

1;
