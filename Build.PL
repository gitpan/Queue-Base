use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Queue::Base',
    license             => 'perl',
    dist_author         => 'Alexei Znamensky <russoz@cpan.org>',
    dist_version_from   => 'lib/Queue/Base.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Queue-Base-*' ],
);

$builder->create_build_script();
