use strict;
use warnings;

use Test::More;


{
    no warnings 'once';
    @File::MimeInfo::DIRS = ('./t/mime'); # forceing non default value
}

opendir MAGIC, 't/magic/';
my @files = grep {$_ !~ /^\./} readdir MAGIC;
closedir MAGIC;

use_ok('File::MimeInfo::Magic', qw/mimetype magic/);

for (@files) {
    my $type = $_;
    $type =~ tr#_#/#;
    $type =~ s#\.\w+$##;
    is( mimetype("t/magic/$_"), $type, "complete (magic) typing of $_");
    undef $type if $type eq "text/plain" || $type eq "application/octet-stream";
    is( magic("t/magic/$_"), $type, "magic typing of $_" );
}

done_testing;
