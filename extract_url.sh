#!/bin/bash

# Mention any schema you want to parse
schema="(https?|phar|ftp|smtp)"

find_dir(){ 
	cd $1
	grep -rhEo "$schema:[^\"< \']+" | sed -e's/\/\+/ /g' | sed 's/://g'
	cd - 1>/dev/null
}

find_web_page()
{
	curl $1 2>/dev/null | grep -Eo "$schema:[^\"< \']+" | sed -e's/\/\+/ /g' | sed 's/://g'
}

usage()
{	
	echo "$0 [-d dir | -u url] [path]"
	echo "    -d | --dir [Directory]"
	echo "    -u | --url [URL]"	
}

if [ $# -eq 2 ]; then
	case $1 in
	-d | --dir )      find_dir $2
		                ;;
	-u | --url )    	find_web_page $2
		                ;;
	-h | --help )     usage
		                exit
		                ;;
	* )               echo "Invalid usage!"
										usage
		                exit 1
	esac
else
	echo "Invalid Usage!"
	usage
fi
