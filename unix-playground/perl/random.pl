sub Average
{ $n=scalar(@_);
$sum=0;
foreach $item (@_)
{
$sum+=$item;
}
$average=$sum/$n;
#my operator makes variable private
my $b=10;
print “Average for given numbers: $average\n”;
return $average;
}
$a=Average(10,20,30);
print “$a is average,$b”;
# $b doesn’t get printed
