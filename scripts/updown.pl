#! /usr/bin/perl
use Text::UpsideDown;
use feature 'say';
no warnings;
say upside_down( "@ARGV" );
