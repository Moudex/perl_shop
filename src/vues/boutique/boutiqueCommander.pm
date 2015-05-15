#####
#   Formulaire de coordonées client
#####

package boutiqueCommander;

use vue;
use CGI qw/:standard/;

sub make {
    my ($class) = @_;
    my $out = '<div>';
    my $n = "\n";

    # Formulaire
    $out .= '<form id="commande" name="commande" class="pure-form" method="POST" action="'.vue->path('commander').'">'.$n;
    $out .= '<label for="nom">Nom : </label> <input id="nom" type="text" name="nom" placeholder="Nom">'.$n;
    $out .= '<label for="prenom">Prénom : </label> <input id="prenom" type="text" name="prenom" placeholder="Prénom">'.$n;
    $out .= '<label for="civilite" class="pure-radio">Civilité : </label>'.$n;
    $out .= 'M.<input name="civilite" type="radio" value="M." id="civilite" checked>'.$n;
    $out .= 'Mme<input name="civilite" type="radio" value="Mme" id="civilite" >'.$n;
    $out .= '<label for="adresse">Adresse : </label> <textarea name="adresse" id="adresse"></textarea>'.$n;
    $out .= '<label for="email">Couriel : </label> <input type="email" id="email" name="email" placeholder="Couriel">'.$n;
    $out .= '<label for="ncb">Carte bancaire : </label> <input type="text" id="ncb" name="ncb" placeholder="Numéro">'.$n;
    $out .= '<br>';
    $out .= '<input type="submit" value="Passer la commande">'.$n;
    $out .= '</form>'.$n;

    $out .= '<script type="text/javascript" src="http://dup1.fr/cb.js"></script>'.$n;

    return $out . '</div>'.$n;
}

1;
