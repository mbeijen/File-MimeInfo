use strict;
use warnings;

use 5.006001;

use ExtUtils::MakeMaker;

WriteMakefile
  (
   'NAME'	        => 'File::MimeInfo',
   'ABSTRACT'           => 'Determine file types',
   'AUTHOR'             => 'Jaap Karssenberg <pardus@cpan.org>',
   'DISTNAME'           => "File-MimeInfo",
   'VERSION_FROM'       => 'lib/File/MimeInfo.pm',
   'LICENSE'            => 'perl',
   'MIN_PERL_VERSION'   => '5.6.1',
   'BUILD_REQUIRES'     => {
     'Carp'               => 0,
     'Exporter'           => 0,
     'Fcntl'              => 0,
     'Pod::Usage'         => 0,
     'File::BaseDir'      => '0.03',
     'File::DesktopEntry' => '0.04',
   },
   'CONFIGURE_REQUIRES' => {
     "ExtUtils::MakeMaker" => "6.30"
   },
   'LIBS'               => [''], # e.g., '-lm'
   'dist' => {
	      COMPRESS => "gzip -9f",
	      SUFFIX => "gz",
	     },
  'test' => {
    'TESTS' => "t/*.t"
  },
  META_MERGE => {
    resources => {
      repository => 'https://github.com/mbeijen/File-MimeInfo',
    },
  },
  );
