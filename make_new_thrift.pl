#!/usr/bin/perl

use FindBin;

my $SKEL_DIR="$FindBin::Bin/thrift_skel";
my $SKEL_SUB_SHORTNAME = 'SKEL_SHORTNAME';
my $SKEL_SUB_ERLANGIFIED_LONGNAME = 'SKEL_ERLANGIFIED_LONGNAME';

die "usage: $0 short_name service_name port" unless @ARGV == 3;

my ($SHORT_NAME, $SERVICE_NAME, $SERVICE_PORT) = @ARGV;

my $ERLANG_SERVICE = lcfirst $SERVICE_NAME;

&do("cp -r $SKEL_DIR $SHORT_NAME");

&do("perl -p -i -e 's/$SKEL_SUB_SHORTNAME/$SHORT_NAME/g;' `find $SHORT_NAME -type f`");
&do("perl -p -i -e 's/$SKEL_SUB_ERLANGIFIED_LONGNAME/$ERLANG_SERVICE/g;' `find $SHORT_NAME -type f`");
&do("perl -p -i -e 's/SKEL_PORT/$SERVICE_PORT/g;' `find $SHORT_NAME -type f`");

# Rename
my $files_string = `find $SHORT_NAME -type f -print0`;
my @files = split /\0/, $files_string;

foreach my $file (@files) {
  my $newfile = $file;
  $newfile =~ s/thrift_skel/$SHORT_NAME/;
  print "$file -> $newfile\n";
  rename($file, $newfile);
}


sub do {
  my $todo = shift;
  print "$todo\n";
  system($todo);
}
