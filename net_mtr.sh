#!/bin/bash
time=$(date +"%Y-%m-%d_%H:%M:%S")

URL1="www.allegro.pl"
URL2="www.onet.pl"
URL3="www.ceneo.pl"
URL4="www.wykop.pl"
URL5="www.facebook.com"
URL6="www.filmweb.pl"

PACKETS="10"

function mtr_chceck()
{
	URL=$1
	mtr -rwc $PACKETS $URL
}

function error_check()
{
	FILE=$1
	tail -1 $FILE | head -1 | awk '{print $3}' | tr -d [%]
}

mtr_chceck $URL1 > /home/m/tools/multimedia/allegro
mtr_chceck $URL2 > /home/m/tools/multimedia/onet
mtr_chceck $URL3 > /home/m/tools/multimedia/ceneo
mtr_chceck $URL4 > /home/m/tools/multimedia/wykop
mtr_chceck $URL5 > /home/m/tools/multimedia/facebook
mtr_chceck $URL6 > /home/m/tools/multimedia/filmweb

for file in allegro onet ceneo wykop facebook filmweb
do
	if [[ "$(error_check /home/m/tools/multimedia/$file)" != "0.0" ]] ; then
		mv /home/m/tools/multimedia/"$file" /home/m/tools/multimedia/errors/"$file"_"$time"
	else
		rm /home/m/tools/multimedia/"$file"
	fi
done
