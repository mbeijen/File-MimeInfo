use strict;
use warnings;
use File::Spec;
use Test::More;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

use_ok('File::MimeInfo', qw/extensions mimetype_canon mimetype_isa/);

## test reverse extension lookup

ok( extensions('text/plain') eq 'asc', 'extenions works');
is_deeply( [extensions('text/plain')], [qw#asc txt#], 'wantarray extensions works' );

# call above should have triggered rehash()
{
    no warnings 'once';
    is(scalar(keys %File::MimeInfo::extension), 7, 'extension data is there');
}

## test alias lookup
ok(mimetype_canon('text/plain') eq 'text/plain', 'canon is transparent');
ok(mimetype_canon('application/x-pdf') eq 'application/pdf', 'canon works');

## test subclass lookup
ok(mimetype_isa('text/foo', 'text/plain'), 'implicite text/plain subclass');
is_deeply([mimetype_isa('text/foo')], [qw(text/plain application/octet-stream)], 'implite application/octet-stream subclass');
ok(mimetype_isa('inode/mount-point', 'inode/directory'), 'implicte inode/directory subclass');
ok(mimetype_isa('application/x-perl', 'application/x-executable'), 'subclass form file');
is_deeply([mimetype_isa('application/x-perl')], [qw(application/x-executable text/plain application/octet-stream)], 'subclass list from file');


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
        !defined($default)  &&
        (@other == 1)       &&
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
done_testing;
