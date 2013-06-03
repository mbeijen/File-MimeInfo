require Test::More;

no warnings;
@File::MimeInfo::DIRS = ('./t/mime'); # forceing non default value
#$File::MimeInfo::DEBUG = 1;

opendir MAGIC, 't/magic/';
my @files = grep {$_ !~ /^\./} readdir MAGIC;
closedir MAGIC;

Test::More->import( tests => (2 * scalar(@files) + 1) );

use_ok('File::MimeInfo::Magic', qw/mimetype magic/);

for (@files) {
	$type = $_;
	$type =~ tr#_#/#;
	$type =~ s#\.\w+$##;
	ok( magic("t/magic/$_") eq $type, "magic typing of $_" );
	ok( mimetype("t/magic/$_") eq $type, "complete (magic) typing of $_");
}
