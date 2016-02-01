#!/usr/bin/perl -w
# by MonStream00 made for kali linux

my $filename = 'CPD_ciscoMD5hashTemp.txt';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

my $filename2 = 'CPD_TempPasswords2.txt';
open(my $fhpass, '>', $filename2) or die "Could not open file '$filename2' $!";

@xlat = ( 0x64, 0x73, 0x66, 0x64, 0x3b, 0x6b, 0x66, 0x6f, 0x41,
          0x2c, 0x2e, 0x69, 0x79, 0x65, 0x77, 0x72, 0x6b, 0x6c,
          0x64, 0x4a, 0x4b, 0x44, 0x48, 0x53 , 0x55, 0x42 );
while (<>) {
        if (/(password|secret|md5|key|ascii)\s+7\s+([\da-f]+)/io) {
            if (!(length($2) & 1)) {
                $ep = $2; $dp = "";
                ($s, $e) = ($2 =~ /^(..)(.+)/o);
                for ($i = 0; $i < length($e); $i+=2) {
                    $dp .= sprintf "%c",hex(substr($e,$i,2))^$xlat[$s++];
                }
                s/7\s+$ep/$dp/;
		print $fhpass "$dp\n";
            }
        }
	if (/(password|secret|md5|key|ascii)\s+5\s+((\$1\$)([a-zA-Z0-9]*)(\$)([\S]*))/io) {
	    if (!(length($2) & 1)) {
		print $fh "$2\n";		
		print "Sending to Hashcat ($2) -   ";
	    }
	}
        print;
}
close $fh;
close $fhpass;
system("cat CPD_TempPasswords2.txt | sort | uniq > CPD_TempPasswords3.txt");
system("hashcat CPD_TempPasswords3.txt -r /usr/share/hashcat/rules/best64.rule --stdout > CPD_TempPasswords.txt");
print "Running hashcat on above cisco 5 md5 hashes (please wait 10 - 15 min)\n";
print "   - hashcat using kali's /usr/share/wordlists/*.txt*\n";
system("hashcat -m 500 CPD_ciscoMD5hashTemp.txt /usr/share/wordlists/*.txt* -o CPD_tempcrackedpasswords.txt > /dev/null");
print "   - resulting cracked cisco md5 passwords:\n";
system("cat CPD_tempcrackedpasswords.txt");
print "   - hashcat using above decoded passwords + best64 mangle rule\n";
system("hashcat -m 500 CPD_ciscoMD5hashTemp.txt CPD_TempPasswords.txt -o CPD_tempcrackedpasswords2.txt > /dev/null");
print "   - resulting cracked cisco md5 passwords:\n";
system("cat CPD_tempcrackedpasswords2.txt");
system("rm CPD_*");
