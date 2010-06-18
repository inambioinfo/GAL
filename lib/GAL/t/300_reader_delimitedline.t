#!/usr/bin/perl
use strict;

use Test::More tests => 5;

BEGIN {
	use lib '../../';
	#TEST 1
	use_ok('GAL::Reader::DelimitedLine');
}

my $path = $0;
$path =~ s/[^\/]+$//;
$path ||= '.';
chdir($path);

# TEST 2
my $reader = GAL::Reader::DelimitedLine->new();
isa_ok($reader, 'GAL::Reader::DelimitedLine');

# TEST 3
ok($reader->file('./data/soap_snp.gff'), '$reader->file');

# TEST 4
ok($reader->field_names(qw(seqid source type start end score strand phase
			   attributes)), '$reader->field_names');

# TEST 5
ok($reader->next_record, '$reader->next_record');

################################################################################
################################# Ways to Test #################################
################################################################################

__END__

=head3
# Various other ways to say "ok"
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
