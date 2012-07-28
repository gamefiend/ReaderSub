#! C:\strawberry\perl

use Modern::Perl;
use WebService::Google::Reader;
use Data::Dumper;
use Getopt::Long;
use URI::Escape;

my $tag;
my $feed;

my $options = GetOptions(
						'tag=s' => \$tag,
						'feed=s'	=> \$feed,
						);

usage() unless $feed;
$tag = ($tag) ? $tag : "Technology";

# user variables
# this is something weird that I'm not quite sure I really want to do, but application specific passwords are
# a touch on the hard to remember side
my $user = ""; # fill this in.
my $pass = ""; # fill this in.  If you are usin two factor auth, make sure to get an application password.
# subscription feature.  Will encapsulate in a function later.
my $reader = WebService::Google::Reader->new(
	username => $user,
	password => $pass,
	);

my $error = $reader->error;
if ($error || !($reader)){
	say $error;
	exit;
}

# $feed=uri_escape($feed);
$reader->subscribe($feed);
$error = $reader->error;
if ($error || !($reader)){
	say $error;
	exit;
}

$reader->tag_feed($feed,$tag);
$error = $reader->error;
if ($error || !($reader)){
	say $error;
	exit;
}

sub usage {
	say "addsub --feed <URL> -[--tag] <category>";
	say "\tdefault category is tag, feed is a mandatory field";
	exit;
}