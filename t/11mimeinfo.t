use strict;
use warnings;

use Test::More;

use File::Spec;
use FindBin qw($Bin);
my $mimetype_file = File::Spec->catfile($Bin, '..', 'mimetype');

my %tests = (
    'mimeopen', 'application/x-perl',
    't/test.png', 'image/png',
);

for my $test (sort keys %tests) {
    my $result = $tests{$test};
    is(`$^X $mimetype_file --noalign $test`, "$test: $result\n", $test);
    is(`$^X $mimetype_file --noalign --stdin < $test`, "STDIN: $result\n",
        "$test (stdin)");
}

done_testing;
