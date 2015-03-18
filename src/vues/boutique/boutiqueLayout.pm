package boutiqueLayout;

use CGI qw/:standard/;

sub make {
    my ($class, $content, @cats) = @_;
    my $out = "";

    my @links = {};
    ## menu categories
    foreach my $cat (@cats) {
	my $low = lc $cat;
	 push @links, a({href=>"http://dup1.fr/perlshop/categorie/$low"}, $cat);
    }
    $out .= ul( li({-type=>'none'}, @links) );

    ## Content
    $out .= $content;

    return $out;
}

1;
