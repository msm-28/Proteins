use strict;
#use warnings;

opendir my $dir, "/home/frequency_counts/" or die "Cannot open directory: $!";
#my @files = $dir;
my @files= grep { -f && /\.pdb$/ } readdir $dir;
closedir $dir;

foreach my $f(@files)
{
print "You are working on filename : ", $f, "\n";
open(FH, "<", $f);
my %residues=(); 
my %aahash=();

my %final_freq=();
my $count_residues=0;
my @resnames;

my %residues_freq=();
while(<FH>)
{
	#	print $_;
	chomp $_;
	push(my @atoms, split(/\s+/,$_));

	#print @atoms;
	#print $atoms[5];
	 $residues{$atoms[5]}= $atoms[3];

}

foreach(keys %residues)
{
	#print "$_\t$residues{$_}\n";
	$count_residues++;
	push(@resnames,$residues{$_});
}

my @amino_acids =('ALA','VAL','LEU','ILE','MET','CYS','PHE','TRP','TYR','GLN','ASP','GLU','LYS','ARG','GLY','PRO','HIS','SER','THR','ASN');

foreach(@resnames)
{
	$residues_freq{$_}++;
}

foreach(@amino_acids)
{
	$aahash{$_}++;
}



foreach(keys %aahash)
{
	$final_freq{$_}=$residues_freq{$_};	
}

foreach my $k (sort keys %final_freq)
{
	print "$k\t$final_freq{$k}\n";
}

print "Total	",$count_residues,"\n";
}
foreach(reverse sort {$residues{$a} <=> $residues{$b}} keys (%residues)){print "$_\t$residues{$_}\n"}
