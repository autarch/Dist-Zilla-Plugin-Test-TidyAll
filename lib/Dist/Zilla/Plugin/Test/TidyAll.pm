package Dist::Zilla::Plugin::Test::TidyAll;

use strict;
use warnings;
use namespace::autoclean;

our $VERSION = '0.05';

use B;
use Dist::Zilla::File::InMemory;

use Moose;

has conf_file => (
    is        => 'ro',
    isa       => 'Str',
    predicate => '_has_conf_file',
);

has verbose => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

has jobs => (
    is      => 'ro',
    isa     => 'Int',
    default => 1,
);

has minimum_perl => (
    is        => 'ro',
    isa       => 'Str',
    predicate => '_has_minimum_perl',
);

with qw(
    Dist::Zilla::Role::FileGatherer
    Dist::Zilla::Role::PrereqSource
);

sub register_prereqs {
    my ($self) = @_;

    $self->zilla->register_prereqs(
        {
            type  => 'requires',
            phase => 'develop',
        },
        'Test::Code::TidyAll' => '0.50',
        'Test::More'          => '0.88',
    );

    return;
}

sub gather_files {
    my ($self) = @_;

    $self->add_file(
        Dist::Zilla::File::InMemory->new(
            {
                name    => 'xt/author/tidyall.t',
                content => $self->_file_content,
            }
        ),
    );

    return;
}

sub _file_content {
    my $self = shift;

    my $content = <<'EOF';
# This file was automatically generated by Dist::Zilla::Plugin::Test::TidyAll v$VERSION

use Test::More 0.88;
EOF

    if ( $self->_has_minimum_perl ) {
        $content .= sprintf( <<'EOF', ( $self->minimum_perl ) x 2 );
BEGIN {
    if ( $] < %s ) {
        plan skip_all => 'This test requires Perl version %s';
    }
}
EOF
    }

    $content .= <<'EOF';
use Test::Code::TidyAll 0.24;

EOF

    my @args;
    if ( $self->_has_conf_file ) {
        ## no critic (Subroutines::ProhibitCallsToUnexportedSubs)
        push @args, ' conf_file => ' . B::perlstring( $self->conf_file );
        ## use critic
    }

    push @args,
        ' verbose => ( exists $ENV{TEST_TIDYALL_VERBOSE} ? $ENV{TEST_TIDYALL_VERBOSE} : '
        . ( $self->verbose ? 1 : 0 ) . ' )';
    push @args,
        ' jobs => ( exists $ENV{TEST_TIDYALL_JOBS} ? $ENV{TEST_TIDYALL_JOBS} : '
        . $self->jobs . ' )';

    my $args = join q{}, map { $_ . ",\n" } @args;
    $args =~ s/^/    /gm;

    $content .= <<"EOF";
tidyall_ok(
$args);

done_testing;
EOF

    return $content;
}

__PACKAGE__->meta->make_immutable;

1;

# ABSTRACT: Adds a tidyall test to your distro

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::Test::TidyAll

=head1 SYNOPSIS

  [Test::TidyAll]

=head1 DESCRIPTION

This is a L<Dist::Zilla> plugin that create a tidyall test in your distro
using L<Test::Code::TidyAll>'s C<tidyall_ok> sub.

L<Code::TidyAll> C<0.24> and L<Test::More> C<0.88> will be added as C<develop
requires> dependencies.

=head1 CONFIGURATION

This plugin accepts the following configuration options:

=head2 conf_file

If this is provided, it will be passed to the C<tidyall_ok> sub.

Note that you must provide a configuration file, either by using one of the
default files that L<Test::Code::TidyAll> looks for, or by providing another
file via this option.

=head2 minimum_perl

If set, then this test will be skipped when run on Perls older than the one
asked for. This is needed if you want to test your distribution on Perls where
some of your tidyall plugins cannot run.

Note that this will be compared to C<$]> so you should pass a version like
C<5.010>, not a v-string like C<v5.10>.

=head2 jobs

Set this to a value greater than one to enable parallel testing. This default
to 1. Note that parallel testing requires L<Parallel::ForkManager>.

=head2 verbose

If this is true, then the verbose flag is set to true when calling
C<tidyall_ok>.

=head1 TEST_TIDYALL_VERBOSE ENVIRONMENT VARIABLE

If you set the C<TEST_TIDYALL_VERBOSE> environment variable (to any value,
true or false), then this value takes precedence over the C<verbose> setting
for the plugin.

If you set the C<TEST_TIDYALL_JOBS> environment variable (to any value,
true or false), then this value takes precedence over the C<jobs> setting
for the plugin.

=head1 WHAT TO IGNORE IN YOUR TIDYALL CONFIG

Many other plugins also add files to the final distro, and these may not pass
your tidyall checks. You will need to ignore these files files in your tidyall
config.

Because of the way tidyall works, you'll also want to ignore the F<blib>
directory. Here is a suggested set of C<ignore> directives for a dzil-based
distro.

    ignore = t/00-*
    ignore = t/author-*
    ignore = t/release-*
    ignore = blib/**/*
    ignore = .build/**/*
    ignore = {{Your-Plugin-Name}}*/**/*

This presumes that you will not create any tests of your own that start with
"00-".

=cut
