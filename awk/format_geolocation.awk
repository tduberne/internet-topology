#!/bin/env awk

BEGIN {
	OFS=","
	print "nid", "lat", "long"
}

{
	sub(":","",$2);
	print $2, $7, $8
}
