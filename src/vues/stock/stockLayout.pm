#####
#   Layout partie stock
#
#   Ce fichier construit la partie stock
#   Lien vers différente gestion des produits et commandes
#####

package stockLayout;

use CGI qw/:standard/;

sub make {
    my ($class, $content) = @_;
    my $out = '<div id="block2"><p class="p2">Level 2</p>';

    $out .= '<ul><li><a href="./stock/commande/">Commandes</a></li><li>Approvisionnement</li><li>Nouveau produit</li></ul>';

    ## Content
    $out .= $content;

    $out .= '</div>';
    return $out;
}

1;
