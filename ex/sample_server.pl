#!/usr/bin/perl
use warnings;
use strict;

my $server = MyApp::Server->new();

$server->run;

package MyApp::Server;
use base qw/HTTP::Server::Simple::Mason/;

sub mason_config {
    return ( comp_root => '/tmp/mason-pages' );
}

1;
