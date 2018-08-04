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
    'Scalar::Util'       => 0,
  },
  'CONFIGURE_REQUIRES' => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  'TEST_REQUIRES' => {
      'Test::More' => '0.88',
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
    # a list of our awesome contributors generated from git
    # using the command:
    # git shortlog -se | cut  -f2- | sed "s/^/        '/;s/$/',/"
    x_contributors => [
        'Bernhard Rosenkränzer <bero@lindev.ch>',
        'Christian Ludwig <chrissicool@gmail.com>',
        'David Steinbrunner <dsteinbrunner@pobox.com>',
        'Jitka Plesnikova <jplesnik@redhat.com>',
        'Jonathan Dowland <jmtd@debian.org>',
        'Michiel Beijen <michiel.beijen@gmail.com>',
        'Nitish Bezzala <nbezzala@yahoo.com>',
        'Patrick Burroughs (Celti) <celti@celti.name>',
        'Rudolf Leermakers <rudolf@hatsuseno.org>',
        'Sean Smith <ssmith@ncsgraphics.com>',
        'Stefan Seifert <nine@detonation.org>',
        'brian m. carlson <sandals@crustytoothpaste.net>',
        'gregor herrmann <gregoa@debian.org>',
    ],
  },
);
