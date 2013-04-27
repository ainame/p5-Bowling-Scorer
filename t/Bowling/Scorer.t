use strict;
use warnings;

use Test::Pretty;
use Test::More;
use Test::Warn;

my $class;
BEGIN {
    $class = "Bowling::Scorer";
    use_ok $class;
}

subtest "#new" => sub {
    my $subject = $class->new;
    isa_ok $subject, $class;
};

subtest "#calc" => sub {
    my $subject;
    my $setup = sub { $subject = $class->new };
    my $teardown = sub { $subject = undef };

    subtest "when calculate 1 frame score" => sub {
        subtest "given no result" => sub {
            $setup->();
            is $subject->calc(), 0,
                "it should return 0.";
            $teardown->();
        };

        subtest "given 1 roll" => sub {
            $setup->();

            is $subject->calc("1"), 1;

            $teardown->();
        };

        subtest "given 2 roll" => sub {
            $setup->();

            is $subject->calc("17"), 8;

            $teardown->();
        };

        subtest "given strike" => sub {
            $setup->();

            my $actual;
            warning_is { $actual = $subject->calc("X"); } "Score can't be determined.";
            is $actual, undef;

            $teardown->();
        };

        subtest "given spare" => sub {
            $setup->();

            my $actual;
            warning_is { $actual = $subject->calc("28"); } "Score can't be determined.";
            is $actual, undef;

            $teardown->();
        };

        subtest "given miss" => sub {
            $setup->();

            is $subject->calc("--"), 0;

            $teardown->();
        };
    };

};

done_testing;
