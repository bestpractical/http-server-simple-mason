#!/usr/bin/perl
use warnings;
use strict;

my $server = MyApp::Server->new();

$server->run;

package MyApp::Server;
use base qw/HTTP::Server::Simple::Mason/;

sub handler_config {
    my $self = shift;
    return ( $self->SUPER::handler_config, comp_root => '/tmp/mason-pages' );
}

1;
