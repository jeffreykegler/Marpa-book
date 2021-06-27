use 5.010;

use warnings;
use strict;
use Memory::Usage;
my $mu = Memory::Usage->new();
use Marpa::R2;

my $symbols = 1;
my $input_size = 20;

$input_size = $ARGV[0] if defined $ARGV[0];
$symbols = $ARGV[1] if defined $ARGV[1];
say STDERR "s=$symbols t=$input_size";

# Record amount of memory used by current process
$mu->record('BEFORE');

my @source = ();
push @source,  <<'END_OF_DSL';
:default ::= action => [name,values]
lexeme default = action => [ start, length, value ]
    latm => 1

# standard part of grammar
top ::= guarded_items
top ::= guarded_unicorns
guarded_items ::= item_guard items
item_guard ~ 'x'
guarded_unicorns ::= unicorn_guard unicorns
unicorn_guard ~ [^\d\D]
unicorn_token ~ [^\d\D]
items ::= item*
unicorns ::= unicorn*
item ::= token token ~ 'x'
END_OF_DSL

for (my $i = 0; $i < $symbols; $i++) {
  push @source, "unicorn ::= unicorn$i unicorn$i ::= unicorn_token";
}
my $source = join "\n", @source;

my $grammar = Marpa::R2::Scanless::G->new( { source => \$source } );
my $recce = Marpa::R2::Scanless::R->new( { grammar => $grammar } );

# Record amount of memory used by current process
$mu->record('DURING');

my $input = 'x' x $input_size;
$recce->read(\$input);
# say $recce->show_progress(0,1);
# say $recce->show_progress(-3, -1);

# Record amount in use afterwards
$mu->record('AFTER');

# Spit out a report
$mu->dump();
