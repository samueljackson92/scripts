use strict;
use warnings;
use Getopt::Long;

GetOptions('sign=s' => \my $sign,
			'limit=i' => \my $limit);

map {print $_} (+, 0..$limit); print "\n";
