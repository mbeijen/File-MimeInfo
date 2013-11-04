use Test::More;
eval 'use Test::CPAN::Changes 0.18';
plan skip_all => 'Test::CPAN::Changes 0.18 or later required for this test' if $@;
changes_ok();
