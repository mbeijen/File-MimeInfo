
use strict;

use Test::More;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

use_ok('File::MimeInfo', qw/mimetype describe globs/);

# test what was read
{
    no warnings; # don't bug me because I use these vars only once
    File::MimeInfo::rehash();
    ok(scalar(keys %File::MimeInfo::literal) == 1, 'literal data is there');
    ok(scalar(@File::MimeInfo::globs) == 1, 'globs data is there');
}

# test _glob_to_regexp
my $i = 0;
for my $glob (
  [ '*.pl',      [ '(?-xism:^.*\.pl$)',        '(?^u:^.*\.pl$)',        '(?^:^.*\.pl$)' ] ],
  [ '*.h++',     [ '(?-xism:^.*\.h\+\+$)',     '(?^u:^.*\.h\+\+$)',     '(?^:^.*\.h\+\+$)' ] ],
  [ '*.[tar].*', [ '(?-xism:^.*\.[tar]\..*$)', '(?^u:^.*\.[tar]\..*$)', '(?^:^.*\.[tar]\..*$)' ] ],
  [ '*.?',       [ '(?-xism:^.*\..?$)',        '(?^u:^.*\..?$)',        '(?^:^.*\..?$)' ] ],
  )
{
  my $converted = File::MimeInfo::_glob_to_regexp( $glob->[0] );
  my $number    = ++$i;
  if ( my ($match) = grep { $_ eq "$converted" } @{ $glob->[1] } ) {
    pass( 'glob ' . $number . ' matches an expected value' );
    note explain $match;
    next;
  }
  fail( 'glob ' . $number . ' matches an expected value' );
  diag explain { got => "$converted", expected_one_of => $glob->[1] };
}

# test parsing file names
$i = 0;
for (
    ['script.pl', 'application/x-perl'],
    ['script.old.pl', 'application/x-perl'],
    ['script.PL', 'application/x-perl'],
    ['script.tar.pl', 'application/x-perl'],
    ['script.gz', 'application/x-gzip'],
    ['script.tar.gz', 'application/x-compressed-tar'],
    ['INSTALL', 'text/x-install'],
    ['script.foo.bar.gz', 'application/x-gzip'],
    ['script.foo.tar.gz', 'application/x-compressed-tar'],
    ['makefile', 'text/x-makefile'],
    ['./makefile', 'text/x-makefile'],
) { is( mimetype($_->[0]), $_->[1], 'file '.++$i ) }

# test OO interface
my $ref = File::MimeInfo->new ;
is(ref($ref), q/File::MimeInfo/, 'constructor works');
is( $ref->mimetype('script.pl'), 'application/x-perl', 'OO syntax works');

# test default
is( mimetype('t/default/binary_file'), 'application/octet-stream', 'default works for binary data');
is( mimetype('t/default/plain_text'), 'text/plain', 'default works for plain text');
is( mimetype('t/default/empty_file'), 'text/plain', 'default works for empty file');
ok( ! defined mimetype('t/non_existing_file'), 'default works for non existing file');
is( mimetype('t/default/utf8_text'), 'text/plain', 'we speak utf8' );
is( mimetype('t/default/encoding_breakage'), 'application/octet-stream', 'encoding bug gone' );

# test inode thingy
is( mimetype('t'), 'inode/directory', 'directories are recognized');

SKIP: {
    unlink 't/symlink' or die "Could not unlink t/symlink"
        if -l 't/symlink';
    skip('symlink not supported', 1)
        unless eval { symlink("",""); 1 }
        and symlink('t/default' => 't/symlink') ;
    is( mimetype('t/symlink'), 'inode/symlink', 'symlinks are recognized');
}

# test describe
ok( describe('text/plain') eq 'Plain Text', 'describe works' );
{
    no warnings; # don't bug me because I use this var only once
    $File::MimeInfo::LANG = 'nl';
}
ok( describe('text/plain') eq 'Platte tekst', 'describe works with other languages' );

is( mimetype('t/test.png'), 'image/png', 'glob priority observed');

done_testing;
