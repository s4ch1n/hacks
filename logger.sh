#!/bin/bash

SCRIPT_LOG=${SCRIPT_LOG:-/dev/null};

function INFO(){
    if [ "$LOGGER_LEVEL" == "DEBUG" ] || [ "$LOGGER_LEVEL" == "INFO" ] ; then
    	local msg="$1"
    	timeAndDate=`date`
    	echo -e "[$timeAndDate] [INFO]  $msg" | tee -a  $SCRIPT_LOG
    fi
}

function DEBUG(){
    if [ "$LOGGER_LEVEL" == "DEBUG" ] ; then
        local msg="$1"
        timeAndDate=`date`
        echo -e "[$timeAndDate] [DEBUG]  $msg" | tee -a  $SCRIPT_LOG
    fi
}

function ERROR(){
    if [ "$LOGGER_LEVEL" == "DEBUG" ] || [ "$LOGGER_LEVEL" == "INFO" ] || [ "$LOGGER_LEVEL" == "ERROR" ] ; then
        local msg="$1"
        timeAndDate=`date`
        echo -e "[$timeAndDate] [ERROR]  $msg"  | tee -a  $SCRIPT_LOG
	exit 1;
    fi
}
