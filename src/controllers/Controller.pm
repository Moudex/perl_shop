#!/usr/bin/env perl

package Controller;
use strict;
use CGI;

my $path = "./";
my $cgi = new CGI()

# Constructeur
sub new {
    my($classe) = @_;
    my $this = {};
    bless($this, $classe);
    return $this;
}

sub render {
    my ($this, $content) = @_;
    # TODO Charger template global

    # Response
    print $cgi->header(-type=>'text/html', -charset=>'utf-8', -status=>'200 Ok');
    print $cgi->start_html(-title=>'Boutique');
    print $content;
    print $cgi->end_html();
}

sub redirect {
    my ($this, $url) = @_;
    print $cgi->redirect(-uri=>$url, -status=>'303 See Other');
}

sub notFound {
    my ($this) = @_;
    # TODO Charger template global
    # TODO Faire cadre d'erreur
    print $cgi->header(-type=>'text/html', -charset=>'utf-8', -status=>'404 Not Found');
    print $cgi->start_html(-title=>'404 Not Found');
}

1;
