#!/usr/bin/perl

# Impostando questa var. impongo un flush dei caratteri per ogni write e print
$|=1;

$TAGNAME=$ARGV[0];
$TAGID=$ARGV[1];

# Directory dove memorizza le immagini temporanee JPG e quelle RGB
$IMAGEDIR="/tmp/images";
system("/home/pi/utility/mk_ramdisk.sh");

# Verifico la presenza dei comandi wget e convert
$WGETCMD=`which wget`;
chop( $WGETCMD);
if ( $WGETCMD eq "") {
        print "ERRORE: wget non trovato\n";
        exit;
}
#
$CNVCMD=`which mogrify`;
chop( $CNVCMD);
if ( $CNVCMD eq "") {
        print "ERRORE: mogrify non trovato\n";
        exit;
}
#
$XMLCMD=`which xmlstarlet`;
chop( $XMLCMD);
if ( $XMLCMD eq "") {
        print "ERRORE: xmlstarlet non trovato\n";
        exit;
}

#
unlink("$IMAGEDIR/$TAGNAME.html");
unlink("$IMAGEDIR/flick_$TAGNAME.lst");
#unlink glob "$IMAGEDIR/flick_$TAGNAME*.jpg";

system("$WGETCMD -q --no-cache  --output-document $IMAGEDIR/$TAGNAME.html \"http://api.flickr.com/services/feeds/groups_pool.gne\?id=$TAGID\&lang=it-it\&format=rss_200\"");

system("$XMLCMD sel -t -m \'//media:content\' -v \@url -n $IMAGEDIR/$TAGNAME.html > $IMAGEDIR/flick_$TAGNAME.lst");

#
open(LSTFILE,"$IMAGEDIR/flick_$TAGNAME.lst") || die "Non posso aprire file list\n";

$num=1;
while(<LSTFILE>) {
	chop;
	$URL=$_;
	system( "$WGETCMD --quiet  --output-document $IMAGEDIR/flick_$TAGNAME$num.jpg $URL");
	#system( "/usr/bin/montage $IMAGEDIR/flick_$TAGNAME$num.jpg -geometry 1366x768 -background black $IMAGEDIR/flick_$TAGNAME$num.jpg");
	$num++;
}
#
close (LSTFILE);
#
unlink("$IMAGEDIR/$TAGNAME.html");
unlink("$IMAGEDIR/flick_$TAGNAME.lst");


