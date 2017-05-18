#!/bin/bash

################################################################################
#
#       ./batchexecute.sh <filepath> <batchsize>
#
#    <filepath>   - File contains list of files/directories to be processed.
#    <batchsize>  - Batch size, specifies the number of files to be processed at a time
#
#   set the environment variable COMMAND
#
################################################################################

function groupExec() {
  hdfsFilesListFile=${1};
  batchSize=${2};
  [[ ! -f "${hdfsFilesListFile}" ]] && ERROR "File Missing"
  lineCount=`cat ${hdfsFilesListFile} | wc -l | tr -d ' '`
  [ $lineCount -eq 0 ] && ERROR "Empty file - ${hdfsFilesListFile}";
  INFO "Total dir count  - $lineCount";
  totalIterations=$((lineCount/batchSize))  ; remainder=$((lineCount/batchSize)) ; [ $remainder -gt 0 ] && ((totalIterations++))

  INFO "Total steps - $totalIterations"
  for((startIndex=1,endIndex=$batchSize,i=1;startIndex<=lineCount;startIndex=startIndex+batchSize,endIndex=endIndex+batchSize,i++))
  do
    [ $endIndex -gt $lineCount ] && endIndex=$lineCount;
    filesList=`sed -n "${startIndex},${endIndex}p" $hdfsFilesListFile | tr '\n' ' ' `;
    INFO "Executing command step - $i/$totalIterations";
    $COMMAND ${filesList} &>/dev/null
    INFO "Done $startIndex - $endIndex"
  done
}

source  logger.sh
export LOGGER_LEVEL="INFO";
export COMMAND="hadoop fs -du -s -h";

[[ "$#" -eq 0 ]] && echo "File Missing" && exit 1;

filesList="${1}"
batchSize=${2:-"700"};

INFO "Deleting files inside ${filesList} with batch size - ${batchSize}";

groupExec ${filesList} ${batchSize}
