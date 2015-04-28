#####
#   Formulaire pour un produit
#####

package stockProduitForm;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, $cats_ref, $prod) = @_;

    my %cats = %$cats_ref;

    my $out = '<div>';

    if ($prod->{id} == undef) {
	$out .= '<h3>Nouveau produit</h3>';
    } else {
	$out .= '<h3>Modifier produit</h3>';
    }

    ## Formulaire
	if ($prod->{id} == undef) {
	    $out .= '<form name="produit" method="POST" action="' .vue->path('stock/produit/new'). '">';
	} else {
	    $out .= '<form name="produit" method="POST" action="' .vue->path('stock/produit/edit/'.$prod->{id}). '">';
	}

	# Nom
	$out .= '<p><label for="nom">Nom : </label> <input type="text" name="nom" value="'.$prod->{nom}.'"></p>';

	# Description
	$out .= '<p><label for="desc">Description : </label> <textarea name="desc">'.$prod->{desc}.'</textarea></p>';

	# Catégorie
	$out .= '<p><label for="cat">Catégorie : </label> <select name="cat">';
	foreach my $key (keys %cats) {
	    if ($cats{$key} == $prod->{cat}){
		$out .= '<option value="'.$cats{$key}.'" selected="selected">'.$key.'</option>';
	    } else{
		$out .= '<option value="'.$cats{$key}.'">'.$key.'</option>';
	    }
	}
	$out .= '</select></p>';

	# Prix
	$out .= '<p><label for="prix">Prix unitaire : </label> <input type="text" name="prix" value="'.$prod->{prix}.'"></p>';

	# Photo
	$out .= '<p><label for="photo">Photo (url) : </label> <input type="text" name="photo" value="'.$prod->{photo}.'"></p>';

	# Quantitée
	$out .= '<p><label for="qte">Quantitée : </label> <input type="text" name="qte" value="'.$prod->{quantite}.'"></p>';

	$out .= '<p><input type="submit"></p>';
	$out .= '</form>';

    $out .= '</div>';
    return $out;
}


1;
