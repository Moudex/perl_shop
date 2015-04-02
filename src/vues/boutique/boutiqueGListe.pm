######
#   Grande Liste
#
#   Ce fichier fait une grande liste de produits sous forme de tableau
######

package boutiqueGListe;

use CGI qw/:standard/;

sub make {
    my ($class, $produits) = @_;
    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .=  $produits->toString();

    $out .= '</div>';
    return $out;
}

1;
