package Controller;

use strict;
use CGI;

use layout;

my $path = "./";

# Constructeur
sub new {
    my($class, $title, $form) = @_;
    my $this = {};
    $this->{title} = $title;
    $this->{form} = $form;
    $this->{cgi} = new CGI();
    bless($this, $class);
    return $this;
}

sub render {
    my ($this, $content) = @_;
    # Response
    print $this->{cgi}->header(-type=>'text/html', -charset=>'utf-8', -status=>'200 Ok');
    
    # Appeler le layout
    print layout->make($content);
}

sub redirect {
    my ($this, $url) = @_;
    print $this->{cgi}->redirect(-uri=>$url, -status=>'303 See Other');
}

sub notFound {
    my ($this) = @_;
    # TODO Charger template global
    # TODO Faire cadre d'erreur
    print $this->{cgi}->header(-type=>'text/html', -charset=>'utf-8', -status=>'404 Not Found');
    print $this->{cgi}->start_html(-title=>'404 Not Found');
}

1;
