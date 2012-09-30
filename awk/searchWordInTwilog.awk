#========================================
# Author : TearTheSky
# This Program is count tweets contained
# keyword as your input form Twilog CSV
# File
#=======================================

#BEGIN routine conma is Field Separater.
BEGIN{
	#Set Field Separater is Conma
	FS=","
	#Keyword Hits Counter
	hits = 0
	#Require User Input
	#This Is Used as Search Keyword
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
	#Print Search Result
        print "---------- R E S U L T ----------"
        print "     " hits "Tweets Hits !"
        print "---------------------------------"
        print ""
}
