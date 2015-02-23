use strict;
use warnings;

use Test::More;
use File::MimeInfo qw(mimetype inodetype globs);

eval "use Path::Tiny";
if ($@) {
  plan skip_all => "module Path::Tiny not installed \n";
}

is(mimetype(path('test.png')), 'image/png',  'mimetype of test.png');
is(inodetype(path('test.png')), undef,       'inodetype of test.png');
is(globs(path('test.png')),     'image/png', 'globs of test.png');

done_testing;
