use 5.010;


use warnings;
use strict;
use Memory::Usage;
my $mu = Memory::Usage->new();
use Marpa::R2;

my $tokens = 1;
my $input_size = 20;

$input_size = $ARGV[0] if defined $ARGV[0];
$tokens = $ARGV[1] if defined $ARGV[1];
say STDERR "$tokens $input_size";

# Record amount of memory used by current process
$mu->record('BEFORE');

my $grammar = Marpa::R2::Scanless::G->new(
    {   source        => \(<<'END_OF_DSL'),
:default ::= action => [name,values]
lexeme default = action => [ start, length, value ]
    latm => 1

# standard part of grammar
top ::= item*
item ::= token token ~ 'x'
item ::= unicorn1 unicorn1 ~ [\D\d]
END_OF_DSL
    }
);

my $recce = Marpa::R2::Scanless::R->new( { grammar => $grammar } );

my $input = 'x' x $input_size;
$recce->read(\$input);

# Record amount in use afterwards
$mu->record('AFTER');

# Spit out a report
$mu->dump();
