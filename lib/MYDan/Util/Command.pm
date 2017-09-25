package MYDan::Util::Command;
use strict;
use warnings;
use Carp;
use MYDan;

sub new
{
    my ( $class, $name, @cmd ) = @_;
    bless +{ name => $name, cmd => \@cmd }, ref $class || $class;
}

sub do
{
    my ( $this, $cmd, @argv )= @_;

    my ( $c ) = grep{ $cmd && $_->[0] eq $cmd }@{$this->{cmd}};

    $this->help() and return unless $c;

    map{ exec join( ' ', "$MYDan::PATH/$_", @argv ) if -e "$MYDan::PATH/$_" }splice @$c, 2;
    print "$cmd is not installed\n";
}

sub help
{
    my $this = shift;

    my ( $name, $cmd ) = @$this{qw( name cmd )};

    print "Usage: $name COMMAND [arg...]\n\nCommands:\n";
    map{ print "\t$_->[0]\t$_->[1]\n"; }@$cmd;
    print "\nRun '$name COMMAND --help' for more information on a command.\n"
}

1;
__END__
