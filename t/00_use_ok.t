use Test::More tests => 4;
require_ok('File::MimeInfo');
require_ok('File::MimeInfo::Magic');
require_ok('File::MimeInfo::Rox');
SKIP: {
	eval "use File::DesktopEntry";
	skip('File::DesktopEntry not installed', 1) if $@;
	require_ok('File::MimeInfo::Applications');
}
