use strict;
use warnings;

use Test::More;
use File::MimeInfo qw[extensions];

# https://github.com/mbeijen/File-MimeInfo/issues/31
{
    local $_ = 'test';

    my @extensions = eval {
        extensions($_) for qw[application/x-perl];
    };

    if ($@ && $@ =~ m[^Modification of a read-only value]) {
        fail 'regression issue #31; exception thrown using extensions() with non-localized read-only $_ in scope';
    } else {
        pass 'no exception thrown using exceptions() with read-only $_ in scope';
    }

    is $_, 'test', 'extensions() does not clobber $_';
}

done_testing;

1;
