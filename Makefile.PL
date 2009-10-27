
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Pod-Elemental-Transformer-WikiDoc',
  NAME      => 'Pod::Elemental::Transformer::WikiDoc',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "a\ transformer\ to\ replace\ \"wikidoc\"\ data\ regions\ with\ Pod5\ elements",
  VERSION   => '0.093000',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Pod::Elemental" => '0.092941',
    "namespace::autoclean" => '0',
    "Pod::WikiDoc" => '0.18',
    "Moose::Autobox" => '0.10',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t'}
);

