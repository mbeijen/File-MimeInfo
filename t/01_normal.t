
use strict;

use Test::More tests => 30;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

use_ok('File::MimeInfo', qw/mimetype describe globs/); # 1

# test what was read
{
	no warnings; # don't bug me because I use these vars only once
	File::MimeInfo::rehash();
	ok(scalar(keys %File::MimeInfo::literal) == 1, 'literal data is there');	# 2
	ok(scalar(@File::MimeInfo::globs) == 1, 'globs data is there');			# 3
}

# test _glob_to_regexp
my $i = 0;
for my $glob (
  [ '*.pl',      [ '(?-xism:^.*\.pl$)',        '(?^u:^.*\.pl$)',        '(?^:^.*\.pl$)' ] ],           # 4
  [ '*.h++',     [ '(?-xism:^.*\.h\+\+$)',     '(?^u:^.*\.h\+\+$)',     '(?^:^.*\.h\+\+$)' ] ],        # 5
  [ '*.[tar].*', [ '(?-xism:^.*\.[tar]\..*$)', '(?^u:^.*\.[tar]\..*$)', '(?^:^.*\.[tar]\..*$)' ] ],    # 6
  [ '*.?',       [ '(?-xism:^.*\..?$)',        '(?^u:^.*\..?$)',        '(?^:^.*\..?$)' ] ],           # 7
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
	['script.pl', 'application/x-perl'],		# 8
	['script.old.pl', 'application/x-perl'],	# 9
	['script.PL', 'application/x-perl'],		# 10 - case insensitive use of glob
	['script.tar.pl', 'application/x-perl'],	# 11
	['script.gz', 'application/x-gzip'],		# 12
	['script.tar.gz', 'application/x-compressed-tar'],	# 13
	['INSTALL', 'text/x-install'],			# 14
	['script.foo.bar.gz', 'application/x-gzip'],	# 15
	['script.foo.tar.gz', 'application/x-compressed-tar'],	# 16
	['makefile', 'text/x-makefile'],		# 17
	['./makefile', 'text/x-makefile'],		# 18
) { is( mimetype($_->[0]), $_->[1], 'file '.++$i ) }

# test OO interface
my $ref = File::MimeInfo->new ;
is(ref($ref), q/File::MimeInfo/, 'constructor works'); # 19
is( $ref->mimetype('script.pl'), 'application/x-perl', 'OO syntax works'); # 20

# test default
is( mimetype('t/default/binary_file'), 'application/octet-stream', 'default works for binary data');	# 21
is( mimetype('t/default/plain_text'), 'text/plain', 'default works for plain text');			# 22
is( mimetype('t/default/empty_file'), 'text/plain', 'default works for empty file');			# 23
ok( ! defined mimetype('t/non_existing_file'), 'default works for non existing file');		# 24
is( mimetype('t/default/utf8_text'), 'text/plain', 'we speak utf8' );		# 25
is( mimetype('t/default/encoding_breakage'), 'application/octet-stream', 'encoding bug gone' );		# 26

# test inode thingy
is( mimetype('t'), 'inode/directory', 'directories are recognized'); # 27

SKIP: {
	unlink 't/symlink' or die "Could not unlink t/symlink"
		if -l 't/symlink';
	skip('symlink not supported', 1)
		unless eval { symlink("",""); 1 }
		and symlink('t/default' => 't/symlink') ;
	is( mimetype('t/symlink'), 'inode/symlink', 'symlinks are recognized'); # 28
}

# test describe
ok( describe('text/plain') eq 'Plain Text', 'describe works' ); # 29
{
	no warnings; # don't bug me because I use this var only once
	$File::MimeInfo::LANG = 'nl';
}
ok( describe('text/plain') eq 'Platte tekst', 'describe works with other languages' ); # 30

