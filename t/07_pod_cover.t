use Test::More;
use File::BaseDir qw/xdg_data_dirs/;
$ENV{XDG_DATA_DIRS} = join ':', 'share', xdg_data_dirs;

eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage" if $@;
all_pod_coverage_ok();
