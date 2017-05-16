#!/usr/bin/env perl

use Mojolicious::Lite;
use strict;

my $index_file = "$ENV{HOME}/nest.index";
system("touch $index_file") unless -f $index_file;

get '/' => sub {
  my $c = shift;
  open F, $index_file or die "can't open $index_file to read: $!";
  my @out = <F>;
  close F;
  $c->render(text => join "", @out );
};

post '/add' => sub {
    my $c = shift;
    my $name = $c->param('name');
    my $url = $c->param('url');
    if ($name && $url){
      my %index = read_index();
      $index{$name} = $url;
      write_index(\%index);
    }else{
      die 'usage: POST /add name=$name url=$url'
    }
    $c->render(text => "add $name $url OK\n")
};

post '/delete' => sub {
    my $c = shift;
    my $name = $c->param('name');
    if ($name){
      my %index = read_index();
      delete $index{$name};
      write_index(\%index);
    }else{
      die 'usage: POST /delete name=$name'
    }
    $c->render(text => "remove $name OK\n")
};

sub read_index {
  open F, $index_file or die "can't open $index_file to read: $!";
  my %index;
  while (my $i = <F>){
    chomp $i;
    if ($i=~/(\S+)\s+(\S+)/){
      $index{$1} = $2;
    };
  }    
  close F;  
  return %index;
};

sub write_index {
  my $index = shift;
  open F, '>', $index_file or die "can't open $index_file to write: $!";
  for my $name (keys %{$index}){
    my $url = $index->{$name};
    next unless $url;
    print F "$name $url\n";
  }    
  close F;  
  return;
};

post '/purge' => sub {
    my $c = shift;
    system("echo > $index_file");
    $c->render(text => "index purged OK\n")
};

app->start;
