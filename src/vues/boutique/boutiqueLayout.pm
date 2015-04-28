#####
#   Layout partie boutique
#
#   Ce fichier construit de la partie boutique.
#   Lien de navigation des différentes catégories
#####

package boutiqueLayout;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, $content, @cats) = @_;
    my $out = '<div>';

    $out .= '<h2>Boutique</h2>';

    ## menu categories
    $out .= '<ul>';
    foreach my $cat (@cats) {
	my $low = lc $cat;
	$out .= '<li><a href="' .vue->path('categorie/'.$low). '">' .$cat. '</a></li>';
    }
    $out .= '</ul>';

    ## Content
    $out .= $content;

    $out .= '</div>';
    return $out;
}

1;
