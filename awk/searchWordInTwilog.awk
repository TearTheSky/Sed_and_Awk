#////////////////////////////////////////////////////////////////////////////////
# Author        : TearTheSky
# Function      :
#       C[ount] : This Program Counts Your Tweets Contained
#                 Keyword You Want
#       Q[uit]  : Exit Program
#
#////////////////////////////////////////////////////////////////////////////////

#============================================================
#
#============================================================
function CountSearchWord(searchWord, input) {
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


function reportStatisticsTweet(searchWord, input) {
	# variable setting
        allTweets = 0			# tweets
	endOfLine = 1			# flag of check inputfile's end
						# 1:exist next line
						# 0:end line
 	index_arrayOfMonth = 0		#"arrayOfMonth"'s index
	lastMonthlyPost = " "

       while(endOfLine > 0) {
		endOfLine = getline < input
 		aRecord = $0
		# if tweet contains CR, read next line
		while ($0 !~ /"$/) {
 			getline < input
			aRrecord = aRecord $0
		}
		# make array of a tweet log
		split(aRecord,aTweetArray)

		# 1件のつぶやきから時刻と内容を分離
		when =  aTweetArray[2]
		status = aTweetArray[3]

		# $1の時間を扱いやすいように分解
                year = "20" substr(when,2,2)
		month = substr(when,4,2)
		day = substr(when,6,2)
		hour = substr(when,9,2)
		minutes = substr(when,11,2)
		second = substr(when,13,2)

		#年月単位でのインデックスの設定
		monthlyPost = year "年" month "月"
			
		#それが月初のつぶやきかの判定
		if(lastMonthlyPost != monthlyPost && length(monthlyPost) ~ 8) {
			#月別つぶやき数の初期化
			quantityOfMonthlyTweets[monthlyPost] = 1
		
			#年月の設定
			index_arrayOfMonth++
			arrayOfMonth[index_arrayOfMonth] = monthlyPost
			lastMonthlyPost = monthlyPost
		}

		#作成したインデックスを使って配列につぶやきを格納
		if(blockOfTweetArray[monthlyPost] = "") {
			blockOfTweetArray[monthlyPost] = status
		}
		else {
			blockOfTweetArray[monthlyPost] = blockOfTweetArray[monthlyPost] + "" + status
		}
		#全つぶやき数のカウント
		allTweets++
		
		#月別のつぶやき数のカウント
		quantityOfMonthlyTweets[monthlyPost] = quantityOfMonthlyTweets[monthlyPost] + 1

		#いま処理しているつぶやきに指定した単語が
		#含まれているかを確認
                if($3 ~ searchWord) {
                        hits++
                }
                else {
                        #next
                }
        }
        close(input)
        #Print Search Result
	print ""
        print "-------------------- つぶやき統計レポート --------------------"
        print " [対象ファイル名] "
	print " " ARGV[1]
	print ""
	print " [対象ファイル内の全つぶやきに関する統計]"
	print " ファイル内の全つぶやき数：" allTweets
	print " 検索ワード「" searchWord "」を含むつぶやきの件数：" hits
	printf(" 検索ワード「%s」の出現率：%.2f%\n",searchWord, hits / allTweets * 100)
	print ""

	#for(each)文を回して月別の統計を出力する。
	for(postedMonth in arrayOfMonth) {
	        print " [月別つぶやき統計：" arrayOfMonth[postedMonth]  "]"
		print " " arrayOfMonth[postedMonth] "のつぶやき数：" quantityOfMonthlyTweets[arrayOfMonth[postedMonth]]
		printf " 対象ファイル全つぶやきに対する当月のつぶやき率："
		printf("%.2f%\n",(quantityOfMonthlyTweets[arrayOfMonth[postedMonth]] / allTweets) * 100)
		print ""
	}
        print "--------------------------------------------------------------"
        print ""
}


#============================================================
#BEGIN routine conma is Field Separater.
#============================================================
BEGIN{
	FS = ","
	MODE = "" 
}

#============================================================
#MAIN routine
#============================================================
{
	while(MODE !~ /[qQ]/) {
        	print ""
		print "=================================================="
        	print "Please Select Analyse Mode"
        	print "--------------------------------------------------"
        	print " A : Analyse Twilog"
        	print " C : Count the Word What You Wnat"
        	print " Q : Quit This Program"
		print "=================================================="
        	print "Please Select Analyse Mode"
        	printf("Your Choice Mode is ... ")

        	#processing branch with MODE
        	#get the MODE what user want
        	getline MODE < "-"

        	#word count mode
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

			CountSearchWord(searchWord, ARGV[1])
        	}
        	#show analyse report mode
        	else if(MODE ~ /[aA]/) {
			print ""
                	print "統計レポート出力モードを選択しました。"
			
	                print ""
                        print "件数を検索したいキーワードを入力してください。"
			print "月別にそのキーワードを含むつぶやきが何件存在"
			print "するのかを確認します。"
                        printf("検索キーワード：")
                        getline searchWord < "-"
			print "レポートを作成しています…しばしお待ちを;)"

                        reportStatisticsTweet(searchWord, ARGV[1])
        	}
	}
	exit
}

#============================================================
#END routine
#============================================================
END{
        print "Thankyou for Playing me! goodbey!"
	print ""
}


