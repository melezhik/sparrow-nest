use Dancer2;
 
get '/' => sub {
  return 'Hello World!';
};
 
start;
