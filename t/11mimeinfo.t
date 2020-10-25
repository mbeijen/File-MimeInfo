use strict;
use warnings;

use Test::More;
use File::MimeInfo;
use File::Spec;
use File::Temp;
use FindBin qw($Bin);

eval "use IO::Scalar";
my $have_io_scalar = !$@;

if (!File::MimeInfo::has_mimeinfo_database()) {
    plan skip_all => "No mimeinfo database found \n";
}

my $empty_dir = File::Temp::tempdir();

my $mimetype_file = File::Spec->catfile($Bin, '..', 'mimetype');

my %tests = (
    'mimeopen', 'application/x-perl',
    't/test.png', 'image/png',
);

for my $test (sort keys %tests) {
    my $result = $tests{$test};
    is(`$^X $mimetype_file --noalign $test`, "$test: $result\n", $test);
    is($?, 0);
    SKIP: {
    skip "Skip stdin test because no IO::Scalar", 1 if !$have_io_scalar;
        is(`$^X $mimetype_file --noalign --stdin < $test`, "STDIN: $result\n",
            "$test (stdin)");
    };
    # with empty mimetype dirs, should exit non-zero
    `$^X $mimetype_file --database "$empty_dir" --noalign $test`;
    cmp_ok($?, '>', 0);
}



done_testing;
