#!/bin/bash

# Port Mapper Version 1
# Rich Smith
#
# Version 1 - 
#   I think this is aligning somewhat with the intention of the CTF event, this script is designed to be fast through utilization
#   of the -T5 flag. It's also supposed to be accurate and give the user the ability to double check ports in the event that something
#   is still missing. I'm not entirely certain how the event is planned to go, but I'm assuming we're not supposed to know which lights
#   go with which ports, its simply an "is it open or is it closed" type scenario. I'm also assuming that there will be some kind of 
#   stdout check that a port is open/closed rather than just a light being off. If not then we'd need some kind of photodetector, a piece
#   of equipment that I'm only familiar with in my son's Snap Circuits toy set. In any event, the way this script is supposed to be used
#   is through 2 sets of inputs, the first being an IPv4 address, and then the second an option from the proceeding case statement.
#   Initially the user should select option 1 and do a custom scan, either from ports 1-65,535 or any assortment of port numbers. Doing a
#   test on my own home network it took me about 17 seconds for the script to run when testing the whole 65,536 port range. Following this
#   initial test comes a secondary test set, since I don't couldn't test on filtered services, and I don't know if that'll be apart of the
#   challenge, I setup a filtered services file that would be created following the run of the second test. After that its going to come
#   down to finding any missing ports and getting rid of any ports that slipped by on accident. The script does contain a filter for closed
#   ports however as of 2/10/2025 I haven't set up a way to generate that list unless a smaller custom list is started from the beginning.
#
#   Any and all help for revision towards this would be appreciated.

echo "Enter target IP address: "
read ipv4

read_ports() {
    input_file="$1"
    while IFS= read -r PORT; do
        output=$(nmap -p $PORT -T5 $ipv4 | tail -n +6 | head -n -3)
        # head and tail command allow me to view information as it comes across in stdout by only showing me as 
        # little information as I possibly need. From my understanding we only care if a port is open or closed
        # and so this gets rid of the rest of the junk, leaving us with port #, port status, and port service.
        echo "$output"
        if [[ "$output" == *open* ]]; then
            printf "%s\n" $PORT >> openports.txt
            # becomes the new list of verified open ports to run against
        elif [[ "$output" == *closed* ]]; then
            printf "%s\n" $PORT >> clsdports.txt
            # used for checking purposes in case nmap misidentified a port, this list can be run by itself and as long as
            # none of the ports end up showing open this file can be trashed. This should only end up being run 
        elif [[ "$output" == *filtered* ]]; then
            printf "%s\n" $PORT >> filtports.txt
            # used for just in case a port isn't mapped because nmap cannot disginguish if a port is open or not
        else
            echo "Something went wrong"
        fi
    done < $input_file
}

echo "1. Initial or incremental port scan"
echo "2. Confirmed open ports file"
echo "3. Closed ports file"
echo "4. Filtered ports file"
echo ""
echo "Enter which option to use for the port file "

read portselector;
echo ""

case $portselector in
    1) echo "Enter port range (ex 22-80): "
        read ports
        output=$(nmap -p $ports -T5 $ipv4 | tail -n +6 | head -n -3 | grep -oP '^\d+')
        printf "%s\n" $output
        printf "%s\n" $output > testports.txt
        echo ""
        ;;
    2) read_ports "testports.txt";;
    3) read_ports "openports.txt";;
    4) read_ports "clsdports.txt";;
    5) read_ports "filtports.txt";;
esac

