#####
#   Produit
#
#   Visualisation d'un produit
#####

package boutiqueProduit;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, %args) = @_;
    my $n = "\n";
    my $t = "\t";
    my $produit = $args{produit};
    my $out = '<div>'.$n;

    $produit->{desc} =~ s/\n/<br>/g;
    
    # Affichage du produit
    $out .= $t.'<div class="pure-g">'.$n;
    $out .= $t.$t.'<div class="photo-box-u-1 u-med-1-2">'.$n;
    $out .= $t.$t.$t.'<a data-im="yes" href="'.$produit->{photo}.'"><img class="pure-img" src="'.$produit->{photo}.'" alt="photo du produit" /></a>'.$n;
    $out .= $t.$t.'</div>'.$n;
    $out .= $t.$t.'<div class="text-box-u-1 u-med-1-2">'.$n;
    $out .= $t.$t.$t.'<ul class="pure-menu-list media-list">'.$n;
    $out .= $t.$t.$t.$t.'<li><h1>'.$produit->{nom}.'</h1></li>'.$n;
    $out .= $t.$t.$t.$t.'<li><h3>Description</h3><p>'.$produit->{desc}.'</p></li>'.$n;
    $out .= $t.$t.$t.$t.'<li><h2>'.$produit->{prix}.'€</h2></li>'.$n;
    if ($produit->{quantite} > 0) {
	$out .= $t.$t.$t.$t.'<li><span style="text-color:green;">Disponible - Livraison sous 48H</span>'.$n;
	$out .= $t.$t.$t.$t.$t.'<form id="commande" name="commande" class="agauche" method="POST" action="'.vue->path('panier/add/'.$produit->{id}).'">Quantité : <input type="text" id="qte" name="qte" value="1" size="3"><input type="submit" value="Ajouter au panier"></form></li>'.$n;
    } else {
	$out .= $t.$t.$t.$t.'<li><span style="text-color:red;">Indisponible pour le moment</span></li>'.$n;
    }
    $out .= $t.$t.$t.'</ul>'.$n;
    $out .= $t.$t.'</div>'.$n;
    $out .= $t.'</div>'.$n;

    $out .= $t.'<div id="overlay"></div>'.$n;
    $out .= $t.'<script type="text/javascript" src="http://dup1.fr/overlay.js"></script>'.$n;

    $out .= '</div>'.$n;
    return $out;
}

1;
