BEGIN {
	OFS=","
	print "ip_lid", "nid"
}

!/^#/ {
	for (i=1; i <= NF; i++) {
		gsub(":.*", "", $i);
	}

	# Links have more than two nodes, because they correspond to switches to which arbitrary numbers of nodes can connect.
	# Essentially, they are cliques of nodes that can all communicate with each other.
	# This is a useful format to store things in.
	for (i=3; i < NF; i++) {
		print $2, $i
	}
}
