package Pod::Weaver::Plugin::WikiDoc;
{
  $Pod::Weaver::Plugin::WikiDoc::VERSION = '0.093003';
}
use Moose;
with 'Pod::Weaver::Role::Dialect';
# ABSTRACT: allow wikidoc-format regions to be translated during dialect phase


use namespace::autoclean;

use Pod::Elemental::Transformer::WikiDoc;

sub translate_dialect {
  my ($self, $pod_document) = @_;

  Pod::Elemental::Transformer::WikiDoc->new->transform_node($pod_document);
}

1;

__END__

=pod

=head1 NAME

Pod::Weaver::Plugin::WikiDoc - allow wikidoc-format regions to be translated during dialect phase

=head1 VERSION

version 0.093003

=head1 OVERVIEW

This plugin is an exceedingly thin wrapper around
L<Pod::Elemental::Transformer::WikiDoc>.  When you load this plugin, then
C<=begin> and C<=for> regions with the C<wikidoc> format will be translated to
standard Pod5 before further weaving continues.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
