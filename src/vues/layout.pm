#####
#   Layout Global
#
#   Ce fichier construit le layout global du site.
#   Barre de navigation, champ de recherche
#   Inclusion des différentes feuilles de style et du javascript
#####


package layout;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, $content) = @_;
    my $out = "";
    
    ## html document header
    $out .= '<!DOCTYPE html>';
    $out .= '<html lang="fr">';
    $out .= '<head>';
    $out .= '<meta charset="UTF-8" />';
    $out .= '<title>PerlSHOP</title>';
    $out .= '<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css" />';
    $out .= '</head>';

    

    ## add container
    $out .= '<div>';

    ## add navbar
    $out .= nav();

    ## Add content
    $out .= $content;

    #$out .= vue->environs();
    $out .= '</div>';

    ## end html
    $out .= end_html;
    
    return $out;
}

## Fabrique la barre de navigation
sub nav {
    my $out = "";
    $out .= '<div class="nav">';
    $out .= h1('Perl Shop');
    $out .= '<a href="' .vue->path('panier').'">Panier</a>';
    $out .= '</div>';

    return $out;
}

1;
