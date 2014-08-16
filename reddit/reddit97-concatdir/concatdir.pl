#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use File::Find::Rule;

#Perl script for combining sub directories of text files

GetOptions('recursive' => \my $isRecursive,
			'directory=s' => \my $root);

if ($isRecursive) {
	list_dir(File::Find::Rule->directory->in($root));
} else {
	list_files(File::Find::Rule->file->name('*.txt')->maxdepth(1)->in($root));
}

sub list_dir {
	foreach my $dir (@_) {
		my @files = File::Find::Rule->file->name('*.txt')->in($dir);
		if($#files >= 0){			
			print "\n---------------------\n=== LISTING DIRECTORY: $dir\n---------------------\n";
			list_files(@files);
		}	
	}
}

sub list_files {
	foreach my $file (@_) {
	  	open(my $in,  "<",  "$file")  or die "Can't open $file.txt: $!";

		my @parts = split /\//, $file;
		my $name = "=== $parts[$#parts](".(-s $file)." bytes)\n";
		print $name;
		print my @lines = <$in>;
		print "\n";

		close $in or die "$in: $!";
	}
}
