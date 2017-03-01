#!/usr/bin/perl

#must be run as root
$first = 1;

#add path if needed into $smartctl_cmd
$cmd = "/usr/sbin/ntpq";

$num_args = $#ARGV + 1;
$command = $ARGV[0];
if (($num_args != 2)and(!($command =~ /discovery/))) {
    print "\nUsage: ntp-peers.pl command [peer_ip]\n";
    exit;
}
$dpeer = $ARGV[1];

my @pout = `$cmd -n -c peers localhost | awk 'match(\$1, /[0-9\\.]+/) {print \$1,\$3,\$8,\$9,\$10;}'`;

if ($command =~ /discovery/) {
  my $first = 1;
  print "{\"data\":[";
  foreach my $line (@pout) {
    chomp $line;
    ($peer,$stratum,$delay,$offset,$jitter) = split(" ",$line);
    $peer=~s/(\d+\.\d+\.\d+\.\d+)/$1/g;
    $peer=$1;
    print "," if not $first;
    $first = 0;
    print "{";
    print "\"{#PEER}\":\"$peer\",";
    print "\"{#STRATUM}\":\"$stratum\"";
    print "}";
  }
  print "]}";
}
elsif ($command =~ /stratum/) {
  foreach my $line (@pout) {
    chomp $line;
    ($peer,$stratum,$delay,$offset,$jitter) = split(" ",$line);
    $peer=~s/(\d+\.\d+\.\d+\.\d+)/$1/g;
    $peer=$1;
    if ($peer =~ /$dpeer/) { print "$stratum\n"; }
  }
}
elsif ($command =~ /delay/) {
  foreach my $line (@pout) {
    chomp $line;
    ($peer,$stratum,$delay,$offset,$jitter) = split(" ",$line);
    $peer=~s/(\d+\.\d+\.\d+\.\d+)/$1/g;
    $peer=$1;
    if ($peer =~ /$dpeer/) { print "$delay\n"; }
  }
}
elsif ($command =~ /offset/) {
  foreach my $line (@pout) {
    chomp $line;
    ($peer,$stratum,$delay,$offset,$jitter) = split(" ",$line);
    $peer=~s/(\d+\.\d+\.\d+\.\d+)/$1/g;
    $peer=$1;
    if ($peer =~ /$dpeer/) { print "$offset\n"; }
  }
}
elsif ($command =~ /jitter/) {
  foreach my $line (@pout) {
    chomp $line;
    ($peer,$stratum,$delay,$offset,$jitter) = split(" ",$line);
    $peer=~s/(\d+\.\d+\.\d+\.\d+)/$1/g;
    $peer=$1;
    if ($peer =~ /$dpeer/) { print "$jitter\n"; }
  }
}
else {
  print "$dpeer\n";
}

