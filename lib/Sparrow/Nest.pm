package Sparrow::Nest;

our $VERSION = '0.0.1';

1;

__END__

=pod


=encoding utf8


=head1 SYNOPSIS

Sparrow::Nest - custom Sparrow repository manager.


=head1 Description

This is a simple specification and implementation of Sparrow custom repositories.

=over

=item *

Custom plugins should be hosted as remote Git repositories ( like  L<private sparrow plugins|https://github.com/melezhik/sparrow#private-plugins>  )


=item *

Custom repository is I<just a list> of C<plg-name git-repository> pairs 


=item *

C<nested> - sparrow repository daemon exposes API to: 1) list plugins presented at repository (get index) 2) add/remove plugins from the list 


=item *

L<Sparrow client|https://github.com/melezhik/sparrow#sparrow-client> requests a custom repository index so that
custom sparrow plugins might be accessible at a target machine ( see C<sparrow client setup> section )


=back


=head1 Build status

L<![Build Status](https://travis-ci.org/melezhik/sparrow-nest.svg)|https://travis-ci.org/melezhik/sparrow-nest>


=head1 Install

    $ cpanm Sparrow::Nest


=head1 Usage

    $ nestd start # start nestd daemon
    $ nestd stop  # stop nestd daemon


=head2 API 


=head3 get repository listing (index)

I<GET />

    curl 127.0.0.1:4441


=head3 add plugin to the list (index)

I<POST /add -d plugin-name=plugin-name -d url=$git-remote-url>

    curl -d name=df-check -d url=https://github.com/melezhik/df-check.git  -L  127.0.0.1:4441/add


=head3 remove plugin from the list (index)

I<POST /delete -d plugin-name=$plugin-name>

    curl -d name=df-check -L  127.0.0.1:4441/delete


=head3 Sparrow client setup

On target machine, given a nestd accessible as 192.168.0.1:4441

    $ echo repo: 192.168.0.1:4441 >> ~/sparrow.yaml 

Then get custom repository by:

    $ sparrow index update 


=head1 nestd daemon

C<nestd> is daemon to start customer repository manager.

    nestd $action %options


=head2 Action

=over

=item *

C<start> - start daemon


=item *

C<stop> - stop daemon


=item *

C<restart> - restart daemon


=back


=head2 Options

=over

=item *

C<--host> - sets host


=item *

C<--port> - sets port


=back

Examples:

    nestd start
    nestd start --host 0.0.0.0 --port 4442
    nestd restart
    nestd stop


=head1 See also

L<Sparrow|https://github.com/melezhik/sparrow>


=head1 Author

L<Alexey Melezhik|mailto:melezhik@gmail.com>
