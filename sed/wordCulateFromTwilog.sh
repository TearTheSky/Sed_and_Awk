#! /bin/sh

#this script can Culate one word From CSV @ Twilog
#USAGE:
#	wordCulateFromTwilog filename word
#

count=0 #how many words exist
sed -n s/$2/$2/p $1 > tempResultSed
echo ""
echo "---------- target line ----------"
cat tempResultSed
echo "---------- target line ----------"
echo ""
wc -l tempResultSed > tempCountLine
count=`sed -n 's/\(^[0-9]*\).*/\1/p' tempCountLine`
echo "your search word is : $2 : $count hits!"
echo ""
#rm tempCountLine
#rm tempResultSed
