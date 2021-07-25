use TeX::AutoTeX;
my $t = TeX::AutoTeX->new( workdir => '.', verbose=>1);
$t->process or warn 'processing failed';
