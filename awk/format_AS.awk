BEGIN {
	OFS=","
	print "nid", "AS"
}

NR > 1 {
	print $2, $3
}
