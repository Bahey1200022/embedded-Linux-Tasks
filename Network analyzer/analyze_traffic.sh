#!/usr/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <pcap_file>"
    exit 1
fi

filename="$1"


# Extract file extension
extension="${filename##*.}"

# Check if extension is "pcap"
if [ "$extension" != "pcap" ]; then

    echo "File does not have a .pcap extension."
fi


# get num of packets in pcap file
#tshark -r traffic2.pcap | wc -l
count=$(tshark -r $filename | wc -l)
echo "Number of packets in the pcap file: $count"

# get protocols in pcap file
echo "Protocols in the pcap file:"
tshark -r $filename -z io,phs -q | tr -s ' ' | cut -f 2 -d ' ' | tail -n +7 | head -n -1


# get number of packets for each protocol
tshark -r $filename -q -z io,phs

#get top 5 destination IP addresses