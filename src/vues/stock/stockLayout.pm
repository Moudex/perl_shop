#####
#   Layout partie stock
#
#   Ce fichier construit la partie stock
#   Lien vers différente gestion des produits et commandes
#####

package stockLayout;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, %args) = @_;
    my $out = '';
    my $n = "\n";
    my $t = "\t";
    
    #layout
    $out .= '<div class="pure-g">'.$n;
    
    #nav
    $out .= $t.'<div id="nav" class="pure-u-1 pure-u-md-1-6">'.$n;
    $out .= $t.$t.'<div class="pure-menu">'.$n;
    $out .= $t.$t.$t.'<ul class="pure-menu-list">'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-heading">Commandes</li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/commande/nospray').'" class="pure-menu-link">Non traitées</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/commande/send').'" class="pure-menu-link">Envoyées</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/commande').'" class="pure-menu-link">Liste</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-heading">Produits</li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/produit/rupture').'" class="pure-menu-link">En rupture</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/produit').'" class="pure-menu-link">Liste</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item"><a href="'.vue->path('stock/produit/new').'" class="pure-menu-link">Nouveau</a></li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-heading">Statistiques</li>'.$n;
    $out .= $t.$t.$t.$t.'<li class="pure-menu-item">Ventes du jour: '.$args{vtoday}.'</li>'.$n;
    $out .= $t.$t.$t.'</ul>'.$n;
    $out .= $t.$t.'</div>'.$n;
    $out .= $t.'</div>'.$n;
    
    #main
    $out .= $t.'<div id="stockcontent" class="pure-u-1 pure-u-md-5-6">'.$n;
    $out .= $args{content};
    $out .= $t.'</div>'.$n;
    
    $out .= '</div>';
    
    return $out;
}

1;
