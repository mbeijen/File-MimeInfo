use strict;
use File::Spec;
use Test::More tests => 16;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

use_ok('File::MimeInfo', qw/extensions mimetype_canon mimetype_isa/); # 1

## test reverse extension lookup

ok( extensions('text/plain') eq 'asc', 'extenions works'); # 2
is_deeply( [extensions('text/plain')], [qw#asc txt#], 'wantarray extensions works' ); # 3

{
	# call above should have triggered rehash()
	no warnings; # don't bug me because I use these vars only once
	is(scalar(keys %File::MimeInfo::extension), 7, 'extension data is there');    # 4
}

## test alias lookup
ok(mimetype_canon('text/plain') eq 'text/plain', 'canon is transparent'); # 5
ok(mimetype_canon('application/x-pdf') eq 'application/pdf', 'canon works'); # 6

## test subclass lookup
ok(mimetype_isa('text/foo', 'text/plain'), 'implicite text/plain subclass'); # 7
is_deeply([mimetype_isa('text/foo')], [qw(text/plain application/octet-stream)], 'implite application/octet-stream subclass'); # 8
ok(mimetype_isa('inode/mount-point', 'inode/directory'), 'implicte inode/directory subclass'); # 9
ok(mimetype_isa('application/x-perl', 'application/x-executable'), 'subclass form file'); # 10
is_deeply([mimetype_isa('application/x-perl')], [qw(application/x-executable text/plain application/octet-stream)], 'subclass list from file'); # 11


## Tests for Applications
SKIP: {
	eval { require File::DesktopEntry };
	skip "File::DesktopEntry not installed", 3 if $@;

	use_ok('File::MimeInfo::Applications');


	my %list = (
		'text/plain'    => 'foo.desktop',
		'image/svg+xml' => 'mirage.desktop',
	);

	for my $type (keys %list) {

	my ($default, @other) = mime_applications($type);
	ok (
		!defined($default)	&&
		(@other == 1)		&&
		ref($other[0]) eq 'File::DesktopEntry',
		'mime_application() works'
	);
	is (
		$other[0]->{file},
		File::Spec->catfile('t', 'applications', $list{$type}),
		"desktop file is the right one",
	);
	}
}

