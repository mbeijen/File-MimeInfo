use strict;
use warnings;

use 5.006001;

use ExtUtils::MakeMaker;

WriteMakefile (
  'NAME'             => 'File::MimeInfo',
  'ABSTRACT'         => 'Determine file types',
  'AUTHOR'           => 'Jaap Karssenberg <pardus@cpan.org>',
  'DISTNAME'         => "File-MimeInfo",
  'VERSION_FROM'     => 'lib/File/MimeInfo.pm',
  'LICENSE'          => 'perl',
  'MIN_PERL_VERSION' => '5.6.1',
  'BUILD_REQUIRES'   => {
    'Carp'               => 0,
    'Exporter'           => 0,
    'Fcntl'              => 0,
    'Pod::Usage'         => 0,
    'File::BaseDir'      => '0.03',
    'File::DesktopEntry' => '0.04',
    'XML::LibXML'        => '1.61',
  },
  'CONFIGURE_REQUIRES' => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  'LIBS'      => [''],
  'EXE_FILES' => [ 'mimetype', 'mimeopen' ],
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
      bugtracker => 'https://github.com/mbeijen/File-MimeInfo/issues',
    },
    x_contributors => [
      'Michiel Beijen <michiel.beijen@gmail.com>',
      'Christian Ludwig <chrissicool@gmail.com>',
      'Bernhard Rosenkränzer <bero@lindev.ch>',
      'David Steinbrunner <dsteinbrunner@pobox.com>',
      'Jitka Plesnikova <jplesnik@redhat.com>',
      'Jonathan Dowland <jmtd@debian.org>',
      'Sean Smith <ssmith@ncsgraphics.com>',
      'Stefan Seifert <nine@detonation.org>',
      'brian m. carlson <sandals@crustytoothpaste.net>',
      'Loïc Jean David Arjanen <arjanen.loic@gmail.com>',
    ],
  },
);
