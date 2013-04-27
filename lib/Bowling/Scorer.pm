package Bowling::Scorer;

use strict;
use warnings;

use Carp qw/croak carp/;
use List::Util qw/sum/;
use List::MoreUtils;

use constant {
    MAX_PINS => 10
};

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub calc {
    my ($self, $result) = @_;
    return 0 unless $result;

    if ($result eq "X") {
        carp "Score can't be determined.";
        return undef;
    }
    $result =~ s/-/0/g;

    my @rolls = split //, $result;
    my $score = sum @rolls;

    if ($score == MAX_PINS) {
        carp "Score can't be determined.";
        return undef;
    }

    return $score;
}

1;
