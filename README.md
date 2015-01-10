# NAME

Dist::Zilla::Plugin::Test::TidyAll - Adds a tidyall test to your distro

# VERSION

version 0.01

# SYNOPSIS

    [Test::TidyAll]

# DESCRIPTION

This is a [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) plugin that create a tidyall test in your distro
using [Test::Code::TidyAll](https://metacpan.org/pod/Test::Code::TidyAll)'s `tidyall_ok()` sub.

[Code::TidyAll](https://metacpan.org/pod/Code::TidyAll) `0.24` and [Test::More](https://metacpan.org/pod/Test::More) `0.88` will be added as `develop
requires` dependencies.

# NAME

Dist::Zilla::Plugin::Test::TidyAll

# CONFIGURATION

This plugin accepts the following configuration options:

## conf\_file

If this is provided, it will be passed to the `tidyall_ok()` sub.

Note that you must provide a configuration file, either by using one of the
default files that [Test::Code::TidyAll](https://metacpan.org/pod/Test::Code::TidyAll) looks for, or by providing another
file via this option.

# WHAT TO IGNORE IN YOUR TIDYALL CONFIG

Many other plugins also add files to the final distro, and these may not pass
your tidyall checks. You will need to ignore these files files in your tidyall
config.

Because of the way tidyall works, you'll also want to ignore the `blib`
directory. Here is a suggested set of `ignore` directives for a dzil-based
distro.

    ignore = t/00-*
    ignore = t/author-*
    ignore = t/release-*
    ignore = blib/**/*
    ignore = .build/**/*
    ignore = {{Your-Plugin-Name}}*/**/*

This presumes that you will not create any tests of your own that start with
"00-".

# AUTHOR

Dave Rolsky <autarch@urth.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Dave Rolsky.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
