#####
#   Formulaire pour un nouveau produit
#####

package stockNewProduit;

use CGI qw/:standard/;

sub make {
    my ($class) = @_;

    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .= '<h3>Nouveau produit</h3>';

    # Nom
    

    # Description


    # Catégorie


    # Prix


    # Photo
    

    # Quantitée

    $out .= '</div>';
    return $out;
}


1;
