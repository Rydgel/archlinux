#!/usr/bin/perl
# Author: Anders Ossowicki (desu@fys.ku.dk)
# Released into public domain 070831
use strict;
use warnings;
my ($full, $charge, $rate, $rem); 
 
# Get full capacity
open(INFO, "< /proc/acpi/battery/BAT1/info") or die "Couldn't open info: ".$!;
foreach (<INFO>) {
	$full = $1 if /^last full capacity:\s*(\d*)\s*mAh$/;
}
close(INFO);
 
# Get current state
open(STATE, "< /proc/acpi/battery/BAT1/state") || die $!;
foreach(<STATE>) {
	$charge = $1 if /^charging state:\s*(\w*)$/;
	$rate = $1 if /^present rate:\s*(\d*)\s*mA$/;
	$rem = $1 if /^remaining capacity:\s*(\d*)\s*mAh$/;
}
close(STATE);
 
die "Unable to retrieve charging information" unless $charge;
die "Unable to retrieve remaining battery capacity" unless $rem;
die "Unable to retrieve full battery capacity" unless $full;
my $percent = (($rem/$full) * 100);
if (defined $ARGV[0] && $ARGV[0] eq "-n") {
	printf("%3.0f%%\n", $percent);
	exit 0;
}
 
if ($charge eq 'discharging') {
	if ($rate) {
		my $hour = int(($rem/$rate));
		my $min = ((($rem/$rate))-int(($rem/$rate)))*60;
		printf("Battery discharging, %5.2f%% left. %dh %dm left\n", 
			$percent, $hour, $min);
	} else {
		printf("Battery discharging, %5.2f%% left.\n", $percent);
	}
}
 
print "Battery fully charged\n"  if ($charge eq 'charged');
print "Battery charging\n" if ($charge eq 'charging');
