#!/bin/sh

NAME_FILE="/mnt/hdds/1/dd_1go_"
CPT=0

perform_dd()
{
    NB_DD=$1
    INDEX=0
    while [ "$INDEX" -lt "$NB_DD" ]; do
        dd if=/dev/zero of=$NAME_FILE$CPT bs=1024 count=1024000 &
        INDEX=`expr $INDEX + 1`
        CPT=`expr $CPT + 1`
    done

    # wait that all dd are finished

    while [ `pgrep dd | wc -l`  -ne 0 ]; do
        #echo "waiting all dd to be finshed"
        sleep 10
    done

    echo "$NB_DD dd finished ! "
}

while [ 1 ]; do

    AVAILABLE_DISK_MO=`df -m | grep /mnt/hdds/1 | awk -F " " '{print $4}'`
    AVAILABLE_DISK_GO=`expr $AVAILABLE_DISK_MO / 1000`


    if [ "$AVAILABLE_DISK_GO" -lt 2 ]; then
        #recycling
        echo "recycling !"
        rm `ls -xr $NAME_FILE | head -n 10`

    else
        if [ "$AVAILABLE_DISK_GO" -gt 10 ]; then #max 10 simultaneous dd
            AVAILABLE_DISK_GO=10
        fi
        perform_dd $AVAILABLE_DISK_GO 
    fi
done










