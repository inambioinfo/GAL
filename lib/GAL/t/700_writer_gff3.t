#!/usr/bin/perl
use strict;

use Test::More tests => 1001;

BEGIN {
	use lib '../../';
	#TEST 1
	use_ok('GAL::Writer::GFF3');
	use_ok('GAL::Parser::gff3');
}

my $path = $0;
$path =~ s/[^\/]+$//;
$path ||= '.';
chdir($path);

# TEST 2
my $writer = GAL::Writer::GFF3->new();
isa_ok($writer, 'GAL::Writer::GFF3');

can_ok($writer, qw(file
		   fh
		   data_source
		   get_metadata_text
		   get_comment_text
		   get_feature_text
		   get_features_text
		   write_metadata
		   write_comments
		   write_feature
		   write_features
		   write_file
		 ));

my $parser = GAL::Parser::gff3->new(file => 'data/Homo_sapiens.GRCh37.73.chr22.short.gff3');

isa_ok($parser, 'GAL::Parser::gff3');

ok(my $reader = $parser->reader, '$parser->reader');

isa_ok($reader, 'GAL::Reader::DelimitedLine');

ok($parser->parse_attributes('ID=My_ID;Name=Name1,Name2;'), '$parser->parse_attributes');

my $record;
ok($record = $parser->next_record, '$parser->next_record');

ok($parser->parse_record($record), '$parser->parse_record');

while (my $feature = $parser->next_feature_hash) {
  ok($writer->write_feature($feature), '$writer->write_feature($feature)');
}



################################################################################
################################# Ways to Test #################################
################################################################################

__END__

ok($this eq $that, $test_name);

is  ($this, $that,    $test_name);
isnt($this, $that,    $test_name);

# Rather than print STDERR "# here's what went wrong\n"
diag("here's what went wrong");

like  ($this, qr/that/, $test_name);
unlike($this, qr/that/, $test_name);

cmp_ok($this, '==', $that, $test_name);

is_deeply($complex_structure1, $complex_structure2, $test_name);

can_ok($module, @methods);
isa_ok($object, $class);

pass($test_name);
fail($test_name);

BAIL_OUT($why);
=cut
