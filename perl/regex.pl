use strict;
use warnings;

my $answer = <STDIN>;
chomp($answer);
if ($answer =~ /^[-|+]*\d*\.*\d*$/) {
	print "hi";
} else {
	print "Not floating point...";
}