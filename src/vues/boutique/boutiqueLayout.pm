#####
#   Layout partie boutique
#
#   Ce fichier construit de la partie boutique.
#   Lien de navigation des différentes catégories
#####

package boutiqueLayout;

use CGI qw/:standard/;

sub make {
    my ($class, $content, @cats) = @_;
    my $out = '<div id="block2"><p class="p2">Level 2</p>';

    my @links = {};
    ## menu categories
    foreach my $cat (@cats) {
	my $low = lc $cat;
	 push @links, a({href=>"http://dup1.fr/perlshop/categorie/$low"}, $cat);
    }
    $out .= ul( li({-type=>'none'}, @links) );

    ## Content
    $out .= $content;

    $out .= '</div>';
    return $out;
}

1;
