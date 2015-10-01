#!/bin/sh
touch ~/.feed/temp.tmp
touch ~/.feed/temp4.tmp
if [ -e "~/.feed/list.txt" ]
then
tempk=1
else
touch ~/.feed/list.txt
fi

dialog --ascii-lines --ok-label 'welcome to my RSS' --msgbox '@@@@@@    @@@@@    @@@@@\n@     @  @     @  @     @\n@     @  @        @\n@@@@@@    @@@@@    @@@@@\n@   @          @        @\n@    @   @     @  @     @\n@     @   @@@@@    @@@@@\n' 13 35

while true
do

dialog --ascii-lines --stdout --menu mymenu 20 50 15 R 'Read - read subscribed feeds' S 'Subscribe - new subscription' D 'Delete - delete subscription' U 'Update - update subscription' Q 'Quit' > ~/.feed/temp.tmp
var=`sed -f ~/.feed/temp4.tmp < ~/.feed/temp.tmp`


if [ $var = "R" ]
then
	list=`sed -f ~/.feed/temp4.tmp < ~/.feed/list.txt`
	list2=`echo $list|sed 's/#/ /g'`
	list3=""
	i1=1
	for key1 in $list2
	do
		list3="$list3""$i1 $key1 "
		i1=$(( $i1 + 1 ))
	done
	echo $list3|xargs dialog --ascii-lines --stdout --menu mymenu 20 50 15
elif [ $var = "S" ]
then
	touch ~/.feed/temp2.tmp
	dialog --ascii-lines --stdout --inputbox Subscribe 10 50 > ~/.feed/temp2.tmp
	var2=`sed -f ~/.feed/temp4.tmp < ~/.feed/temp2.tmp`
	./feed.py -u $var2 -t > ~/.feed/temp2.tmp
	newlist=`sed -f ~/.feed/temp4.tmp < ~/.feed/temp2.tmp`
	oldlist=`sed -f ~/.feed/temp4.tmp < ~/.feed/list.txt`
	if [ -n "$newlist" ]
	then
		echo "$oldlist""$newlist""#"|sed 's/ /_/g' > ~/.feed/list.txt
	fi
elif [ $var = "D" ]
then
	list=`sed -f ~/.feed/temp4.tmp < ~/.feed/list.txt`
	list2=`echo $list|sed 's/#/ /g'`
	list3=""
	i1=1
	for key1 in $list2
	do
		list3="$list3""$i1 $key1 "
		i1=$(( $i1 + 1 ))
	done
	
	echo $list3|xargs dialog --ascii-lines --stdout --menu mymenu 20 50 15 > ~/.feed/temp3.tmp
	index=`sed -f ~/.feed/temp4.tmp < ~/.feed/temp3.tmp`
	if [ -n "$index" ]
	then
	list=`sed -f ~/.feed/temp4.tmp < ~/.feed/list.txt`
	list2=`echo $list|sed 's/#/ /g'`
	list3=""
	i2=1
	for key2 in $list2
	do
		if [ $i2 != $index ]
		then
			list3="$list3""$key2""#"
		fi
		i2=$(( $i2 + 1 ))
	done
	echo $list3 > ~/.feed/list.txt
	fi
elif [ $var = "U" ]
then
update=1
elif [ $var = "Q" ]
then
break
else
tempk2=1
fi

done

rm -f ~/.feed/temp.tmp
rm -f ~/.feed/temp2.tmp
rm -f ~/.feed/temp3.tmp
rm -f ~/.feed/temp4.tmp
