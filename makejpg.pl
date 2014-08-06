#!/usr/bin/perl 
use GD;
my $im = 0;
my $r = 0, $g = 0, $b = 0;
my $w = 0, $h = 0;
my $x = 0, $y = 0;

while(<>) {
  if ($_ =~ /^size=(\d+)x(\d+)$/) {
    $w = $1;
    $h = $2;
    $x = 0;
    $y = 0;
    $im = new GD::Image($w,$h);
    $im->fill(0,0,$im->colorResolve(0,0,0));
    last;
  }
}

die "No size=<size>x<size> found\n" unless $im;

while(<>) {
  if ($_ =~ /^([0-9]+) +([0-9]+) +([0-9]+)/) {
    $r = $1;
    $g = $2;
    $b = $3;
    $im->setPixel($x,$y,$im->colorResolve($r, $g, $b));
    $x++;
    if ($x == $w) {
     $x = 0;
     $y++;
    }
  } 
}
binmode STDOUT;

print $im->png;
