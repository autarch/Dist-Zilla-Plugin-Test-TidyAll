# NAME

Dist::Zilla::Plugin::Test::TidyAll - Adds a tidyall test to your distro

# VERSION

version 0.02

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

## verbose

If this is true, then the verbose flag is set to true when calling
`tidyall_ok()`.

# TEST\_TIDYALL\_VERBOSE ENVIRONMENT VARIABLE

If you set the `TEST_TIDYALL_VERBOSE` environment variable (to any value,
true or false), then this value takes precedence over the `verbose` setting
for the plugin.

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

# SUPPORT

Bugs may be submitted through [the RT bug tracker](http://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-Plugin-Test-TidyAll)
(or [bug-dist-zilla-plugin-test-tidyall@rt.cpan.org](mailto:bug-dist-zilla-plugin-test-tidyall@rt.cpan.org)).

I am also usually active on IRC as 'drolsky' on `irc://irc.perl.org`.

# DONATIONS

If you'd like to thank me for the work I've done on this module, please
consider making a "donation" to me via PayPal. I spend a lot of free time
creating free software, and would appreciate any support you'd care to offer.

Please note that **I am not suggesting that you must do this** in order for me
to continue working on this particular software. I will continue to do so,
inasmuch as I have in the past, for as long as it interests me.

Similarly, a donation made in this way will probably not make me work on this
software much more, unless I get so many donations that I can consider working
on free software full time (let's all have a chuckle at that together).

To donate, log into PayPal and send money to autarch@urth.org, or use the
button at [http://www.urth.org/~autarch/fs-donation.html](http://www.urth.org/~autarch/fs-donation.html).

# AUTHOR

Dave Rolsky &lt;autarch@urth.org>

# COPYRIGHT AND LICENCE

This software is Copyright (c) 2015 - 2016 by Dave Rolsky.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
