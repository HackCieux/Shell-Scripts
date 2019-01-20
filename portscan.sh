#!/bin/bash

#populate our variables from the arguments

host=$1
startport=$2
stopport=$3

#function pingcheck
#ping a device to see if it is up

function pingcheck
{
ping=`ping -c 1 $host | grep bytes | wc -l`
if [ "$ping" -gt 1 ];then
echo "$host is up";
else
echo "$host is down quitting";
exit
fi
}

#function portcheck
#test a port to see if it is open

function portcheck
{
for ((counter=$startport; counter<=$stopport; counter++))
do
(echo >/dev/tcp/$host/$counter) > /dev/null 2>&1 && echo "$counter open"
done
}

#run our functions

pingcheck
portcheck
