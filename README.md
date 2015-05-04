# File-MimeInfo

This module can be used to determine the mime type of a file; it's a
replacement for [File::MMagic](https://metacpan.org/pod/File::MMagic)
trying to implement the freedesktop specification for using the shared
mime-info database. The package comes with a script called `mimetype`
that can be used as a `file(1)` work-alike.

## INSTALLATION

To install this module type the following:

    perl Makefile.PL
    make
    make test
    make install

## DEPENDENCIES

This module expects the freedesktop mime database to be installed,
some linux distributions include it, otherwise it can obtained
from:

  http://freedesktop.org/Software/shared-mime-info

This module requires these other modules which can be obtained from
the [CPAN](https://metacpan.org) if they are not already installed on
your system:

* Carp
* Exporter
* Fcntl
* Pod::Usage
* File::Basename
* File::BaseDir
* File::DesktopEntry
* XML::LibXML (depends on Gnome XML library, libxml2-dev)

## COPYRIGHT AND LICENCE

Copyright (c) 2003, 2008 Jaap G Karssenberg. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
