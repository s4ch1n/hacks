#!/bin/bash
# Batch process.

################# How to execute ################# 
# 1. Input txt file location - Input file should contain the file list.
# 2. Update group size Line # - it specifies the number of files to be processed 
# 3. Replace <COMMAND> with the required command. 
###################################################

# Input file 
filename=inputfile.txt

lineCount=`cat $filename | wc -l `
group=25 
start=1; 
end1=$group; 

for((start=1;end1<lineCount;start=start+group,end1=end1+group)) 
do 
	echo "$start : $end1"
    filesList=`sed -n "${start},${end1}p" $filename | tr '\n' ' ' `
# Replace this command. 
	<COMMAND> ${filesList}
 done 

# Replace this command. 
filesList=`sed -n "${start},${end1}p" $filename | tr '\n' ' ' `

<COMMAND> ${filesList}
	
