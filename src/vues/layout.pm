#####
#   Layout Global
#
#   Ce fichier construit le layout global du site.
#   Barre de navigation, champ de recherche
#   Inclusion des différentes feuilles de style et du javascript
#####


package layout;

use CGI qw/:standard/;

sub make {
    my ($class, $content) = @_;
    my $out = "";
    
    ## html document header
    $out .= start_html(
	-title => 'Perl Shop',
	-meta => {},
	-style => {'src' => 'http://dup1.fr/perlshop.css'}
    );

    ## add container
    $out .= '<div id="block1"><p class="p1">Level 1</p>';

    ## add navbar
    $out .= nav();

    ## Add content
    $out .= $content;

    $out .= strenviron();
    $out .= '</div>';

    ## end html
    $out .= end_html;
    
    return $out;
}

## Fabrique la barre de navigation
sub nav {

    my @links = ();
    push (@links, a({href => "http://dup1.fr/perlshop/user"}, "Profil"));
    push (@links, a({href => "http://dup1.fr/perlshop/panier"}, "Panier"));

    my $out = "";
    $out .= '<div class="nav">';
    $out .= h1('Perl Shop');
    $out .= ul( li({-type=>'none'}, @links) );
    $out .= '</div>';

    return $out;
}

## Affiche les variables d'environnement
sub strenviron {
    my $out = "<ul>";
    foreach my $key (sort keys(%ENV)) {
	$out .= "<li>$key = $ENV{$key}</li>";
    }
    return $out . '</ul>';
}

1;
