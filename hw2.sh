#!/bin/sh
geth=0
var_s=0
var_o="sa.out"
var_l=0
var_c=0

while getopts "hs:o:l:c:" myopt
do
	case $myopt in
	h)
	echo 'Usage: ./hw2.sh [-h][-s src][-o output_name][-l lang][-c compiler]'
	geth=1
	;;
	s)
	var_s=$OPTARG
	;;
	o)
	var_o=$OPTARG
	;;
	l)
	var_l=$OPTARG
	;;
	c)
	var_c=$OPTARG
	;;
	esac
done

if [ -e $var_s ]
then
tempi=0
elif [ $geth = "1" ]
then
exit
else
echo 'The file does not exist or you did not give -s value.'
exit
fi

var_l2=`echo $var_l|sed 's/,/ /g'`

for lang in $var_l2
do

if [ $lang = "c" ] || [ $lang = "C" ]
then
	if [ $var_c = "gcc" ]
	then
		cp $var_s "$var_s"temp.c
		gcc -o $var_o "$var_s"temp.c
		rm -f "$var_s"temp.c
		./$var_o
	elif [ $var_c = "clang" ]
	then
		cp $var_s "$var_s"temp.c
		clang -o $var_o "$var_s"temp.c
		rm -f "$var_s"temp.c
		./$var_o
	elif [ $var_c = "0" ]
	then
		cp $var_s "$var_s"temp.c
		gcc -o $var_o "$var_s"temp.c
		rm -f "$var_s"temp.c
		./$var_o
	else
		echo "The C compiler $var_c does not support."
	fi
elif [ $lang = "cc" ] || [ $lang = "cpp" ] || [ $lang = "Cpp" ] || [ $lang = "c++" ] || [ $lang = "C++" ]
then
	if [ $var_c = "g++" ]
	then
		cp $var_s "$var_s"temp.cpp
		g++ -o $var_o "$var_s"temp.cpp
		rm -f "$var_s"temp.cpp
		./$var_o
	elif [ $var_c = "clang++" ]
	then
		cp $var_s "$var_s"temp.cpp
		clang++ -o $var_o "$var_s"temp.cpp
		rm -f "$var_s"temp.cpp
		./$var_o
	elif [ $var_c = "0" ]
	then
		cp $var_s "$var_s"temp.cpp
		g++ -o $var_o "$var_s"temp.cpp
		rm -f "$var_s"temp.cpp
		./$var_o
	else
		echo "The C++ compiler $var_c does not support."
	fi
elif [ $lang = "awk" ] || [ $lang = "AWK" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	./$var_o
elif [ $lang = "perl" ] || [ $lang = "Perl" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	perl $var_o
elif [ $lang = "python" ] || [ $lang = "Python" ] || [ $lang = "py" ] || [ $lang = "python2" ] || [ $lang = "Python2" ] || [ $lang = "py2" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	python2 $var_o
elif [ $lang = "python3" ] || [ $lang = "Python3" ] || [ $lang = "py3" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	python3 $var_o
elif [ $lang = "ruby" ] || [ $lang = "Ruby" ] || [ $lang = "rb" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	ruby $var_o
elif [ $lang = "Haskell" ] || [ $lang = "haskell" ] || [ $lang = "hs" ]
then
	cp $var_s "$var_s"temp.hs
	ghc -o $var_o "$var_s"temp.hs
	rm -f "$var_s"temp.hs
	./$var_o
elif [ $lang = "lua" ] || [ $lang = "Lua" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	lua $var_o
	lua52 $var_o
elif [ $lang = "bash" ] || [ $lang = "Bash" ]
then
	cp $var_s $var_o
	chmod 744 $var_o
	bash $var_o
else
	echo "The language $lang does not support."
fi

echo '==========================='
done
