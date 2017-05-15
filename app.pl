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
  system('touch public/index.txt') unless -f 'public/index.txt';
  open F, "public/index.txt" or die "can't open public/index.txt to read: $!";
  my %index;
  while (my $i = <F>){
    chomp $i;
    my ($name,$url) =  split /\s+/, $i;
    next unless $name;
    next unless $url;
    $index{$name} = {$url};
  }    
  close F;  
  return %index;
};

sub write_index {
  my $index = shift;
  system('touch public/index.txt') unless -f 'public/index.txt';
  open F, '>', "public/index.txt" or die "can't open public/index.txt to write: $!";
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
    system('echo > public/index.txt');
    $c->render(text => "index purged OK\n")
};

app->start;
