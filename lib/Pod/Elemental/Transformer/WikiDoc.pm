package Pod::Elemental::Transformer::WikiDoc;
our $VERSION = '0.093000';


use Moose;
with 'Pod::Elemental::Transformer';
# ABSTRACT: a transformer to replace "wikidoc" data regions with Pod5 elements


use namespace::autoclean;

use Moose::Autobox;

use Pod::Elemental::Types qw(FormatName);
use Pod::WikiDoc;


has format_name => (
  is  => 'ro',
  isa => FormatName,
  default => 'wikidoc',
);


sub transform_node {
  my ($self, $node) = @_;
  my $children = $node->children;

  PASS: for (my $i = 0; $i < $children->length - 1; $i++) {
    my $para = $children->[$i];
    next unless $para->isa('Pod::Elemental::Element::Pod5::Region')
         and    ! $para->is_pod
         and    $para->format_name eq $self->format_name;

    confess "wikidoc transformer expects wikidoc region to contain 1 Data para"
      unless $para->children->length == 1
      and    $para->children->[0]->isa('Pod::Elemental::Element::Pod5::Data');

    my $text    = $para->children->[0]->content;
    my $parser  = Pod::WikiDoc->new;
    my $new_pod = $parser->convert($para->as_pod_string);

    $new_pod =~ s/^# Generated by Pod::WikiDoc version \S+$//sgm;

    my $new_doc = Pod::Elemental->read_string($new_pod);
    Pod::Elemental::Transformer::Pod5->transform_node($new_doc);
    $new_doc->children->shift
      while
      $new_doc->children->[0]->isa('Pod::Elemental::Element::Pod5::Nonpod');

    splice @$children, $i, 1, $new_doc->children->flatten;
  }

  return $node;
}

1;

__END__
=pod

=head1 NAME

Pod::Elemental::Transformer::WikiDoc - a transformer to replace "wikidoc" data regions with Pod5 elements

=head1 VERSION

version 0.093000

=head1 SYNOPSIS

  my $document = Pod::Elemental->read_string( $string );
  Pod::Elemental::Transformer::Pod5->new->transform_node( $document );

  Pod::Elemental::Transformer::WikiDoc->new->transform_node( $document );

...and if you had a section like this:

  =begin wikidoc

  == Look, a header!

  * Foo
  * Bar
  * Baz

  =end wikidoc

...you now have something more like this:

  =head2 Look, a header!

  =over 4
  
  =item Foo

  =item Bar

  =item Baz

  =back

For complete documentation on this dialect, see L<Pod::WikiDoc>.

Possibly the most succinct, powerful use case is this:

  =head2 some_method

  This B<public> method takes the following arguments:

  =for wikidoc
  * name
  * rank
  * serial_number

  =cut

=head1 ATTRIBUTES

=head2 format_name

This attribute indicates the format name of regions to be transformed from
WikiDoc.  By default, the transformer will look for regions of the format
"wikidoc."

=head1 METHODS

=head2 transform_node

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

