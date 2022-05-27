#!/bin/bash
# 
# Quick script to generate random client traffic to a list of servers.
# @author: Matthew Gillespie

SERVERLIST=()
NUMBER_OF_THREADS=5
SERVERFILE="/usr/local/etc/client_traffic_generator.servers"

if [ ! -f $SERVERFILE ];
then
    echo "Server file is not found"
    exit 1;
fi;

while IFS= read -r line; do
        SERVERLIST+=($line)
done < $SERVERFILE


for i in "${SERVERS[@]}"
do
   echo $i
done

create_traffic(){
#Here we select a random server from our list of IPERF3 listeners
TEST_SERVER=${SERVERLIST["$[RANDOM % ${#SERVERLIST[@]}]"]}


echo "We will be sending traffic to $TEST_SERVER"

#Next, we pic a random one of our systemd iperf files and determine what ports we have where we've established listeners
RANDOMPORT=$(ls -1 /etc/systemd/system/iperf3-tcp-port* | shuf -n 1  | sed -e 's/\/etc\/systemd\/system\/iperf3-tcp-port//g' | sed -e 's/\.service//g')
echo "Selecting random port from available IPERF3 listeners -- port $RANDOMPORT"


#Lastly, we run an iperf 1k transfer.
/usr/bin/iperf3 -n 1k -c $TEST_SERVER -p $RANDOMPORT >/dev/null &
}


#Here we create traffic based on the number of threads specified.
for i in $( eval echo {0..$NUMBER_OF_THREADS} )
do
create_traffic
done
