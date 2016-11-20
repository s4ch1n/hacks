#!/bin/bash
# Batch process.

# Input file 
filename=inputfile.txt

lineCount=`cat $filename | wc -l `
group=25 
start=1; 
end1=$group; 

for((start=1;end1<lineCount;start=start+group,end1=end1+group)) 
do 
	echo "$start : $end1"
    fileToMove=`sed -n "${start},${end1}p" $filename | tr '\n' ' ' `
# Replace this command. 
	hadoop fs -mv $fileToMove /user/hive/warehouse/JUNK
 done 

# Replace this command. 
fileToMove=`sed -n "${start},${end1}p" $filename | tr '\n' ' ' `
hadoop fs -mv $fileToMove /user/hive/warehouse/JUNK
	
	
