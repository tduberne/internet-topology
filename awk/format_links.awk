BEGIN {
	OFS=","
	print "ip_lid", "n1", "n2"
}

!/^#/ {
	for (i=1; i <= NF; i++) {
		gsub(":.*", "", $i);
	}

	# Links have more than two nodes, because they correspond to switches to which arbitrary numbers of nodes can connect
	# print only unidirectional links.
	# see during the analysis whether it is worth/possible storing both directions
	for (i=3; i < NF; i++) {
		for (j=i+1; j <= NF; j++) {
			print $2, $i, $j
		}
	}
}
