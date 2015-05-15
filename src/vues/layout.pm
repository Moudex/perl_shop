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
    my ($class, %args) = @_;
    my $out = "";
    my $n = "\n";
    my $t = "\t";
    
    # En-tête
    $out .= '<!DOCTYPE html>'.$n;
    $out .= '<html lang="fr">'.$n;
    $out .= '<head>'.$n;
    $out .= $t.'<meta charset="UTF-8" />'.$n;
    $out .= $t.'<meta name="viewport" content="width=device-width, initial-scale=1.0">'.$n;
    $out .= $t.'<title>PerlSHOP</title>'.$n;

    ## CSS
    $out .= $t.'<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css" />'.$n;
    $out .= $t.'<!--[if lte IE 8]>'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://purecss.io/combo/1.18.13?/css/layouts/gallery-grid-old-ie.css">'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://purecss.io/combo/1.18.13?/css/layouts/gallery-old-ie.css">'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-old-ie-min.css">'.$n;
    $out .= $t.'<![endif]--><!--[if gt IE 8]><!-->'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://purecss.io/combo/1.18.13?/css/layouts/gallery-grid.css">'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://purecss.io/combo/1.18.13?/css/layouts/gallery.css">'.$n;
    $out .= $t.$t.'<link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/grids-responsive-min.css">'.$n;
    $out .= $t.'<!--<![endif]-->'.$n;
    $out .= $t.'<link rel="stylesheet" href="http://dup1.fr/perlshop.css">'.$n;
    $out .= $args{css}.$n;

    $out .= '</head>'.$n;

    

    ## add container
    $out .= '<body>'.$n;

    ## add navbar
    $out .= '<header>'.$n;
    $out .= nav($args{cats}).$n;
    $out .= '</header>'.$n;

    ## Add content
    $out .= $args{content}.$n;

    ## Footer
    $out .= '<div id="footer">';
    $out .= $t.'<p>(c) PerlShop 2015 | <a href="'.vue->path('stock').'">Stock</a></p>';
    $out .= '</div>';

    $out .= '<script type="text/javascript" src="http://dup1.fr/menu.js"></script>'.$n;

    #$out .= vue->environs();
    $out .= '</body>';

    return $out;
}

## Fabrique la barre de navigation
sub nav {
    my ($cats) = @_;
    my $out = "";
    my $n = "\n";
    my $t = "\t";

    $out .= '<nav class="barrenav pure-g" id="menu">'.$n;
    $out .= $t.'<div class="pure-u-1 pure-u-md-1-6">'.$n;
    $out .= $t.$t.'<div class="pure-menu">'.$n;
    $out .= $t.$t.$t.'<a class="pure-menu-heading" href="'.vue->path('').'">Perl Shop</a>'.$n;
    $out .= $t.$t.$t.'<a href="#" class="custom-toggle" id="toggle"><s class="bar"></s><s class="bar"></s></a>'.$n;
    $out .= $t.$t.'</div>'.$n;
    $out .= $t.'</div>'.$n;
    $out .= $t.'<div class="pure-u-1 pure-u-md-5-6">'.$n;
    $out .= $t.$t.'<div class="pure-menu-horizontal custom-can-transform">'.$n;
    $out .= $t.$t.'<ul class="pure-menu-list">'.$n;
    foreach (@$cats) {
	$out .= $t.$t.$t.'<li class="pure-menu-item"><a class="pure-menu-link" href="'.vue->path('categorie/'. lc $_).'">'.$_.'</a></li>'.$n;
    }
    $out .= $t.$t.$t.'<li class="pure-menu-item"><a class="pure-menu-link pure-button" href="'.vue->path("panier").'">Panier</a></li>'.$n;
    $out .= $t.$t.'</ul>'.$n;
    $out .= $t.$t.'</div>'.$n;
    $out .= $t.'</div>'.$n;
    $out .= '</nav>'.$n;

    return $out;
}

1;
