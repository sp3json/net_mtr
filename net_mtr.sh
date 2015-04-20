#!/bin/bash
#
# net_mtr 1.0 copyright marcin@hexdump.pl
#
# Program check connection looses by MTR (http://explainshell.com/explain/8/mtr)
# in last server hop, and store informations to "errors" directory if these occur.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
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

mtr_chceck $URL1 > /path/to/allegro
mtr_chceck $URL2 > /path/to/onet
mtr_chceck $URL3 > /path/to/ceneo
mtr_chceck $URL4 > /path/to/wykop
mtr_chceck $URL5 > /path/to/facebook
mtr_chceck $URL6 > /path/to/filmweb

for file in allegro onet ceneo wykop facebook filmweb
do
    if [[ "$(error_check /path/to/$file)" != "0.0" ]] ; then
        mv /path/to/"$file" /path/to/errors/"$file"_"$time" #must create "errors" directory
    else
        rm /path/to/"$file"
    fi
done
