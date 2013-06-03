#!/usr/bin/perl

use Module::Build;

my $build = Module::Build->new(
	dist_name => 'File-MimeInfo',
	dist_version_from => 'lib/File/MimeInfo.pm',
	dist_author => 'Jaap Karssenberg <pardus@cpan.org>',
	license => 'perl',
	script_files => ['mimetype', 'mimeopen'],
	requires => {
		'Carp'		=> 0,
		'Exporter'	=> 0,
		'Fcntl'		=> 0,
		'Pod::Usage'	=> 0,
		'File::BaseDir'	=> '0.03',
		'File::DesktopEntry' => '0.04',
	},
	#build_requires => {},
	create_makefile_pl => 'passthrough',
	#dynamic_config => 1,
);

$build->create_build_script;

