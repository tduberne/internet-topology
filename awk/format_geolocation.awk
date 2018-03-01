#!/bin/env awk

BEGIN {
	FS="\t"
	OFS=","
	print "nid", "lat", "lon"
}

{
	sub("^node.geo ","",$1);
	sub(":$","",$1);
	print $1, $6, $7
}
