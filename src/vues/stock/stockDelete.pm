#####
#   Confirmation de supression
#####

package stockDelete;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, $prod) = @_;

    my $out = '<div>';

    $out .= '<h3>Spression d\'un produit</h3>';

    $out .= '<p>' .$prod->toString(). '</p>';

    $out .= '<form name="supp" method="POST" action="'.vue->path('stock/produit/delete/'.$prod->{id}).'"><input type="hidden" name="confirm" value="yes"><input type="submit"></form>';

    $out .= '</div>';

    return $out;
}

1;
