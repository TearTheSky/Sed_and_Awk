#========================================
# Author : TearTheSky
# This Program is count tweets contained
# keyword as your input form Twilog CSV
# File
#=======================================

function CountSearchWord2(searchWord, input) {
	nextAct = 1
	while(nextAct > 0) {
	        nextAct = getline < input
	        if($3 ~ searchWord) {
        	        #print $1
	                hits++
	        }
	        else {
	                #next
		}
	}
	close(input)
        #Print Search Result
        print "---------- R E S U L T ----------"
        print "     " hits "Tweets Hits !"
        print "---------------------------------"
        print ""
}

#BEGIN routine conma is Field Separater.
BEGIN{
	MODE = " "
	while(MODE !~ /[qQ]/) {
	print ""
	print "=================================================="
	print "Please Select Analyse Mode"
	print "--------------------------------------------------"
	print " C : Count the Word What You Wnat"
	print " Q : Quit This Program"
        print "=================================================="
	printf("Your Choice Mode is ... ") 

	getline MODE < "-"
	
	if(MODE ~ /[cC]/) {
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

		CountSearchWord2(searchWord, ARGV[1])		
	}
	}
	if(MODE ~ /[qQ]/) {
		exit
	}
}

#MAIN routine
{
}

#END routine
END{
	if(MODE ~ /[qQ]/) {
	        exit
        }
}

