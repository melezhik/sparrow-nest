use inc::Module::Install;

# Define metadata
name           'Sparrow-Nest';
abstract       'Custom Sparrow repository manager';

all_from       'lib/Sparrow/Nest.pm';

# Specific dependencies


requires    'Mojolicious::Lite';
requires    'Starman';
requires    'Plack';

license     'perl';

repository  'https://github.com/melezhik/sparrow-nest';

install_script 'bin/nestd', 'bin/nestd.psgi';

WriteAll;


