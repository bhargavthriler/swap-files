#!/bin/bash
#######################################################################
# Copyright (C) 2021 Bhargav <bhargavdas100@gmail.com>
#
#@file : 
#
#@Description :
#
#@Return : 0 for success and non zero for fail
#
#######################################################################
#
# Revision History:
#
#######################################################################

# setup
setup(){
    case "$1" in
        -f)
            swap_files_rename $2 $3
            ;;
        -c)
            check_conf_file_n_parse $2
            ;;
        -C)
            conf_help
            ;;
        *)
            usage
            ;;
    esac
}

check_conf_file_n_parse(){
    CONF_FILE=$1
    if [[ "$CONF_FILE" == "conf_rename" || "$CONF_FILE" == ".conf_rename" ]];then
        FILE1=$(head -1 ${CONF_FILE})
        check_files_exist $FILE1
        FILE2=$(tail -1 ${CONF_FILE})
        check_files_exist $FILE2

        swap_files_rename $FILE1 $FILE2
    else
        check_files_exist $CONF_FILE
    fi
}

check_files_exist(){
    F_EXIST=$1
    ls $F_EXIST > /dev/null 2>&1
    if [ $? -ne 0 ];then
        echo "$F_EXIST doesn't exist"
        exit 3
    fi
}

swap_files_rename(){
    TEMP_NAME=temp_file_bak
    FILE1=$1
    check_files_exist $FILE1
    FILE2=$2
    check_files_exist $FILE2
    
    mv $FILE1 $TEMP_NAME
    if [ $? -ne 0 ];then
        echo "rename failed from $FILE1 to $TEMP_NAME !!"
        exit 4
    fi
    mv $FILE2 $FILE1
    if [ $? -ne 0 ];then
        echo "rename failed from $FILE2 to $FILE1 !!"
        exit 5
    fi
    mv $TEMP_NAME $FILE2
    if [ $? -ne 0 ];then
        echo "rename failed from $TEMP_NAME to $FILE2 !!"
        exit 6
    fi
}

# usage
usage(){
    echo "Use the following options to swap file1 to file2 and vice versa"
    echo "-f <file1> <file2>"
    echo "-c <config file>"
    echo "-C -h config file help"
    echo "-h display this message"
    exit 1
}

#conf_help
conf_help(){
    echo "config file should be named .conf_rename or conf_rename, used this so that it doesn't conflict with config files"
    echo "content's of config file"
    echo "line1: name of file1"
    echo "line2: name of file2"
}

# main
if [ $# -lt 2 ];then
    usage
fi

setup "$@" 
