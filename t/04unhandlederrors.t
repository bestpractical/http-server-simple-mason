use Test::More;
BEGIN {
    delete @ENV{ qw( http_proxy HTTP_PROXY ) };
    if (eval { require LWP::Simple }) {
	plan tests => 5;
    } else {
	Test::More->import(skip_all =>"LWP::Simple not installed: $@");
    }
}

use_ok( HTTP::Server::Simple::Mason);

my $s=MyApp::Server->new(13432);
is($s->port(),13432,"Constructor set port correctly");
my $pid=$s->background();
like($pid, qr/^-?\d+$/,'pid is numeric');
sleep(1);
my $content=LWP::Simple::get("http://localhost:13432");
ok(!$content,"Returns an empty page");
is(kill(9,$pid),1,'Signaled 1 process successfully');




package MyApp::Server;
use base qw/HTTP::Server::Simple::Mason/;
use File::Spec;
use File::Temp qw/tempdir/;

sub mason_config {
    my $root =  tempdir( CLEANUP => 1 );
    open (PAGE, '>', File::Spec->catfile($root, 'index.html')) or die $!;
    print PAGE '<%die%>';
    close (PAGE);
    return ( comp_root => $root, error_mode => 'fatal', error_format => 'line' );
}

1;
