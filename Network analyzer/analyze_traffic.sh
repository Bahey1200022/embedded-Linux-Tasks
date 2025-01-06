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

echo "Analyzing pcap file: $filename"




# get num of packets in pcap file
#tshark -r traffic2.pcap | wc -l
count=$(tshark -r "$filename" | wc -l)
echo "1. Number of packets in the pcap file: $count"


# get number of packets for each protocol
echo "2. Number of packets for each protocol:"
echo "Number of packets for https/tls protocol:"
tshark -r "$filename" -Y "tls" | wc -l
echo "Number of packets for http protocol:"
tshark -r "$filename" -Y "http" | wc -l

#get top 5 destination IP addresses

echo "3. Top 5 destination IP addresses:"
tshark -r "$filename" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5

# get top 5 source IP addresses
echo "4. Top 5 source IP addresses:"

tshark -r "$filename"  -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5


echo "Done analyzing pcap file: $filename"