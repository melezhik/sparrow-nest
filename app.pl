#!/usr/bin/env perl

use Mojolicious::Lite;
use strict;
use Carp;
use Mojo::Log;

get '/' => sub {
  my $c   = shift;
  
  $c->redirect_to->('/index.txt');
};

# Start the Mojolicious command system
app->start;
