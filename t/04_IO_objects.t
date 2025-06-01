use strict;
use warnings;

use Test::More;

$ENV{XDG_DATA_HOME} = './t/';
$ENV{XDG_DATA_DIRS} = './t/'; # forcing non default value

opendir MAGIC, 't/magic/';
my @files = grep {$_ !~ /\./ and $_ ne 'CVS'} readdir MAGIC;
closedir MAGIC;

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

done_testing;