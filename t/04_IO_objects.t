use strict;
use warnings;
use Test::More;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forceing non default value

opendir MAGIC, 't/magic/';
my @files = grep {$_ !~ /\./ and $_ ne 'CVS'} readdir MAGIC;
closedir MAGIC;

Test::More->import( tests => scalar(@files) );

eval "use File::MimeInfo::Magic"; # force runtime evaluation
die $@ if $@;

unless (eval 'require IO::Scalar') {
    ok(1, 'Skip - no IO::Scalar found') for 0 .. $#files;
}
else {
    for (@files) {
        my $type = $_;
        $type =~ tr#_#/#;

        open FILE, "t/magic/$_" || die $!;
        my $file = join '', (<FILE>);
        close FILE;
        my $io = new IO::Scalar \$file;

        ok( mimetype($io) eq $type, "typing of $_ as io::scalar" )
    }
}

__END__

# Not all platforms seem to support <:encoding(latin2) :(

unless (eval 'require IO::File') {
    ok(1, 'Skip - no IO::File found');
    exit 0;
}

my $io = new IO::File;
$io->open('t/text_plain_czech', '<:encoding(latin2)');
ok( mimetype($io) eq 'text/plain', "czech (ISO 8859-2) encoded text" );
