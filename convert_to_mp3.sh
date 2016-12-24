#!/bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
# IFS=$'\n'

# wmafiles=`find "$1" -name '*.wma'`;
#
# while read -r fname; do
#   echo "$fname";
# done <<< "$wmafiles";

recursiveConvert(){
  for f in "$1"/*; do

     if [ -d "$f" ]; then
       recursiveConvert "$f";
     fi

    if [ -f "$f" ]; then
      # echo "$f";
      if [[ "$f" == *.wav ]]; then
        j="${f%.wav}";
        echo "$j";
        avconv -i "$j.wav" -acodec libmp3lame -ab 320k "$j.mp3" && rm -f "$j.wav"  && echo "$f encoded to mp3"
      elif [[ "$f" == *.wma ]]; then
        j="${f%.wma}";
         echo "$j";
         avconv -i "$j.wma" -acodec libmp3lame -ab 320k "$j.mp3" && rm -f "$j.wma"  && echo "$f encoded to mp3"
      fi
    fi
  done
}

recursiveConvert $1

IFS=$SAVEIFS
