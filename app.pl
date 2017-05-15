use Mojolicious::Lite;
use strict;

get '/index' => sub {
  my $c = shift;
  system('touch public/index.txt') unless -f 'public/index.txt';
  $c->reply->static('index.txt');
};

get '/' => sub {
  my $c = shift;
  $c->redirect_to('index');
};

app->start;
