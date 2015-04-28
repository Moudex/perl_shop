package Controller;

use strict;
use CGI;

use layout;

my $path = "./";

# Constructeur
sub new {
    my($class, $title) = @_;
    my $this = {};
    $this->{title} = $title;
    $this->{cgi} = new CGI();
    bless($this, $class);
    return $this;
}

# Méthode de rendu globale
sub render {
    my ($this, $content) = @_;
    # Response
    print $this->{cgi}->header(-type=>'text/html', -charset=>'utf-8', -status=>'200 Ok');
    
    # Appeler le layout
    print layout->make($content);
}

# Méthode de redirection
sub redirect {
    my ($this, $url) = @_;
    print $this->{cgi}->redirect(-uri=>$url, -status=>'303 See Other');
}

# Page d'erreur 404
sub notFound {
    my ($this) = @_;
    print $this->{cgi}->header(-type=>'text/html', -charset=>'utf-8', -status=>'404 Not Found');
    print layout->make('<h2>Page introuvable !</h2>');
}

# Génère les URL
sub path {
    my ($class, $way) = @_;
    return 'http://'.$ENV{'HTTP_HOST'}.'/perlshop/'.$way;
}

1;
