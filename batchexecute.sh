#!/bin/bash

################# How to execute ################# 
# 1. Pass Input txt file location in the command line 
# 2. Update batch size Line # - it specifies the number of files to be processed at a time.
# 3. Replace <COMMAND> with actual command. 
###################################################

# Input file 
filename="$1";
batchSize=4

if [ "$1" == "" ] || [[ ! -f "$filename" ]] ; then
  echo "File is missing";
  exit 1;
fi

lineCount=`cat $filename | wc -l | tr -d ' '`
[ $lineCount -eq 0 ] && echo "Empty file" && exit 0;

startIndex=1;
endIndex=$batchSize;

for((startIndex=1;startIndex<=lineCount;startIndex=startIndex+batchSize,endIndex=endIndex+batchSize))
  do
    [ $endIndex -gt $lineCount ] && endIndex=$lineCount;
    echo "$startIndex : $endIndex"
    filesList=`sed -n "${startIndex},${endIndex}p" $filename | tr '\n' ' ' `
    # Replace with actual command command.
    # <COMMAND> ${filesList}
done	
