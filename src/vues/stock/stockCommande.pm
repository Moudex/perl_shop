#####
#   Détail commande
#
####

package stockCommande;

use CGI qw/:standard/;

sub make {
    my ($class, $produits) = @_;

    my $out = '<div id="block3"><p class="p3">Level 3</p><br />';

    $out .= '<h3>Détail Commande</h3>';

    $out .= '<table>';
    $out .= '<tr><th>Nom</th><th>Qté.</th><th>Prix U.</th><th>Prix T.</th></tr>';
    foreach my $p (@{$produits->{prodsComs}}) {
	$out .= "<tr><td>$p->{nom}</td><td>$p->{quantitee}</td><td>$p->{prix}</td><td>" .$p->{quantitee}*$p->{prix} ."</td></tr>";
    }
    $out .= '</table>';

    $out .= '</div>';
    
    return $out;
}

1;
