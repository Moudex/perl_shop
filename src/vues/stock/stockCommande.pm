#####
#   Détail commande
#
####

package stockCommande;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class, %args) = @_;
    my $n = "\n";
    my $t = "\t";
    my $out = '<div>'.$n;

    $out .= $t.'<h1>'.$args{titre}.'</h1>'.$n;
    $out .= $t.'<p>Commande : '.$args{commande}->{dateC}.'</p>'.$n;
    $out .= $t.'<p>Paiement : '.$args{commande}->{dateP}.'</p>'.$n;
    if ($args{commande}->{dateE} ne undef) {
	$out .= $t.'<p>Envoi : '.$args{commande}->{dateE}.'</p>'.$n;
    }

    # Client
    $out .= $t.'<h2>Client</h2>'.$n;
    $out .= $t.$t.'<p>'.$args{client}->{civi}.' '.$args{client}->{nom}.' '.$args{client}->{prenom}.'</p>'.$n;
    $out .= $t.$t.'<p>'.$args{client}->{email}.'</p>'.$n;
    $out .= $t.$t.'<p>'.$args{client}->{adresse}.'</p>.'.$n;

    # Produits
    $out .= $t.'<h2>Produits</h2>'.$n;
    $out .= '<table class="pure-table pure-table-bordered pure-table-striped">'.$n;
    $out .= $t.'<thead><tr>'.$n;
    $out .= $t.$t.'<th>Ref.</th><th>Nom</th><th>Prix U.</th><th>Qté.</th><th>Prix T.</th>'.$n;
    $out .= $t.'</tr></thead>'.$n;
    $out .= $t.'<tbody>'.$n;
    my $total = 0;
    foreach (@{$args{produits}->{prodsComs}}) {
	my $pu=$_->{prix}; $pu=~s/,/\./; my $pt=$pu*$_->{quantitee}; $total+=$pt; $pt=~s/\./,/;
	$out .= $t.$t.'<tr>'.$n;
	$out .= $t.$t.$t.'<td class="adroite"><a href="'.vue->path('produit/'.$_->{produit}).'">'.$_->{produit}.'</a></td>'.$n;
	$out .= $t.$t.$t.'<td>'.$_->{nom}.'</td>'.$n;
	$out .= $t.$t.$t.'<td class="adroite">'.$_->{prix}.'€</td>'.$n;
	$out .= $t.$t.$t.'<td class="adroite">'.$_->{quantitee}.'</td>'.$n;
	$out .= $t.$t.$t.'<td class="adroite">'.$pt.'€</td>'.$n;
	$out .= $t.$t.'</tr>'.$n;
    }
    $out.= $t.'</tbody>'.$n;
    $out .= '</table>'.$n;

    $total =~ s/\./,/;
    $out .= '<h2>Total : '.$total.'€</h2>'.$n;

    # afficher si non expédié
    if ($args{commande}->{dateE} eq undef) {
	$out .= '<a href="'.vue->path('stock/commande/exp/'.$args{commande}->{id}).'">Expédier la commande</a>'.$n;
    }

    $out .= '</div>'.$n;
    
    return $out;
}

1;
