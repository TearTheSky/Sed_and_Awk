#========================================
#
#=======================================

#BEGIN routine conma is Field Separater.
BEGIN{
	FS=","
	hits = 0
	print ""
	print "Please The Word What You Want To Search"
	printf("searchWord is :")
	getline searchWord < "-"
}

#MAIN routine
{
	if($3 ~ searchWord){
		#print $1
		hits++
	}
	else{
		#next
	}
}

END{
        print "---------- R E S U L T ----------"
        print "     " hits "Tweets Hits !"
        print "---------------------------------"
        print ""
}
