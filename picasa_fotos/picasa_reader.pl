#!/usr/bin/perl

# Impostando questa var. impongo un flush dei caratteri per ogni write e print
$|=1;

if ( $ARGV[0] eq "") {
	print "ERRORE: fornire nome DB\n";
	print "usage: picasa_reader.pl <db_name> <tb_name> <n_photo>\n"; 
	exit;
}

if ( $ARGV[1] eq "") {
	print "ERRORE: fornire nome tabella\n";
	print "usage: picasa_reader.pl <db_name> <tb_name> <n_photo>\n"; 
	exit;
}

if ( $ARGV[2] eq "") {
	print "ERRORE: fornire numero immagini da scaricare\n";
	print "usage: picasa_reader.pl <db_name> <tb_name> <n_photo>\n"; 
	exit;
}

# Directory dove memorizza le immagini temporanee JPG e quelle RGB
$IMAGEDIR="/tmp/images";
system("./mk_ramdisk.sh");

# Verifico la presenza dei comandi wget e convert
$WGETCMD=`which wget`;
chop( $WGETCMD);
if ( $WGETCMD eq "") {
	print "ERRORE: wget non trovato\n";
	exit;
}

$CNVCMD=`which convert`;
chop( $CNVCMD);
if ( $CNVCMD eq "") {
	print "ERRORE: convert non trovato\n";
	exit;
}


#@listurl=`./geturl.sh picasa.db t_url 16`;
@listurl=`./geturl.sh $ARGV[0] $ARGV[1] $ARGV[2]`;

chop( @listurl);

$num=1;
foreach $line (@listurl) {
	system( "$WGETCMD --quiet --no-check-certificate --output-document $IMAGEDIR/picasa$num.jpg $line");
	$num++;
}



