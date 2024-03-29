
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "a transformer to replace \"wikidoc\" data regions with Pod5 elements",
  "AUTHOR" => "Ricardo SIGNES <rjbs\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Pod-Elemental-Transformer-WikiDoc",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Pod::Elemental::Transformer::WikiDoc",
  "PREREQ_PM" => {
    "Moose" => 0,
    "Moose::Autobox" => "0.10",
    "Pod::Elemental" => "0.092941",
    "Pod::Elemental::Transformer" => 0,
    "Pod::Elemental::Types" => 0,
    "Pod::Weaver::Role::Dialect" => 0,
    "Pod::WikiDoc" => "0.18",
    "namespace::autoclean" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Pod::Elemental" => 0,
    "Pod::Elemental::Transformer::Pod5" => 0,
    "Test::More" => "0.96",
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.093003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



