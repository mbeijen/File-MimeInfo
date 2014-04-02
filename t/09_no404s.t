#!/usr/bin/perl
use strict; use warnings;

use Test::More;

eval "use Test::Pod::No404s";
if ( $@ ) {
        plan skip_all => 'Test::Pod::No404s required for testing POD';
} else {
        all_pod_files_ok();
}
