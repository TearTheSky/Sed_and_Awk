#////////////////////////////////////////////////////////////////////////////////
# Author        : TearTheSky
# Function      :
#       C[ount] : This Program Counts Your Tweets Contained
#                 Keyword You Want
#       Q[uit]  : Exit Program
#
#////////////////////////////////////////////////////////////////////////////////

#============================================================

#============================================================
function getMessage( messageNo ) {

message = messageNo

#-----------------
# Mode_01
#-----------------
messageBox["Mode_01"] = "\n==================================================\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  "Please Select Analyse Mode\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  "--------------------------------------------------\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  " A : Analyse Twilog\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  " C : Count the Word What You Wnat\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  " Q : Quit This Program\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  "==================================================\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  "Please Select Analyse Mode\n"
messageBox["Mode_01"] = messageBox["Mode_01"]  "Your Choice Mode is ... "


#-----------------
# Analyse_01
#-----------------
messageBox["Analyse_01"] = "\n統計レポート出力モードを選択しました。\n"
messageBox["Analyse_01"] = messageBox["Analyse_01"] "件数を検索したいキーワードを入力してください。\n"
messageBox["Analyse_01"] = messageBox["Analyse_01"] "月別にそのキーワードを含むつぶやきが何件存在\n"
messageBox["Analyse_01"] = messageBox["Analyse_01"] "するのかを確認します。\n"
messageBox["Analyse_01"] = messageBox["Analyse_01"] "\n検索キーワード："


printf messageBox[message]

}



#============================================================
# modeSelect(            MODE, existMode)
#============================================================
function modeSelect(		MODE, existMode) {
	
	# /[aAcCqQ]/
	
	#Show Main Menu Message
        getMessage("Mode_01")

	#processing branch with MODE
	#get the MODE what user want
	getline MODE < "-"
	while(MODE !~ /[aAcCqQ]/) {
		print "Oops. your selected mode don't exist"
		print "please retry to select mode"
		printf "Your Choice Mode is ... "
		getline MODE < "-"
	}
	return MODE
}

#============================================================
# CountSearchWord(input)
#============================================================
function CountSearchWord(input) {

	#flag
        nextAct = 1
	#Keyword Hits Counter
	hits = 0
	#Require User Input
	#This Is Used as Search Keyword
	print ""
	print "Please The Word What You Want To Search"
	printf("searchWord is :")
	getline searchWord < "-"

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


#============================================================
#
#============================================================
function reportStatisticsTweet(input) {
	# variable setting
        allTweets = 0			# tweets
	endOfLine = 1			# flag of check inputfile's end
						# 1:exist next line
						# 0:end line
 	index_arrayOfMonth = 0		#"arrayOfMonth"'s index
	lastMonthlyPost = " "

	#show message require input
	printf getMessage("Analyse_01")

        getline searchWord < "-"
        print "レポートを作成しています…しばしお待ちを;)"

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
	for(reportIndex = index_arrayOfMonth; reportIndex >= 1; reportIndex--) {
	        print " [月別つぶやき統計：" arrayOfMonth[reportIndex]  "]"
		print " " arrayOfMonth[reportIndex] "のつぶやき数：" quantityOfMonthlyTweets[arrayOfMonth[reportIndex]]
		printf " 対象ファイル全つぶやきに対する当月のつぶやき率："
		printf("%.2f%\n",(quantityOfMonthlyTweets[arrayOfMonth[reportIndex]] / allTweets) * 100)
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

		MODE = modeSelect()

        	#word count mode
        	if(MODE ~ /[cC]/) {
			CountSearchWord(ARGV[1])
        	}
        	#show analyse report mode
        	else if(MODE ~ /[aA]/) {
                        reportStatisticsTweet(ARGV[1])
        	}
	}
	exit
}

#============================================================
#END routine
#============================================================
END{
        print "Thank you for Playing me! goodbye!"
	print ""
}


