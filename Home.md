# Introduction #

Welcome to the Project Wiki of RadioPlus. This project is for GNU Radio Community under GSoC 2013 program. The project is being done by Shashank Gaur, Paris and mentored by Ankit Kaushik, KIT, Germany.

# Details #


[Wireshark](http://www.wireshark.org/) is a network protocol analyzer which lets you browse network traffic while capable of running on multiple platforms. While [GNU Radio](http://gnuradio.org/redmine/projects/gnuradio/wiki) is a capable to receive, demodulate and process different packets such as IEEE 802.11 a/g/p. This project aims to provide a utility for new users of GNU Radio to access Wireshark and analyze their algorithms using it. It will establish a bridge between GNU Radio and Wireshark with the help of available PDU and OFDM codes. This would result into analysis of packets, received and processed by the GNU Radio, using Wireshark, and to analyze Packet Error Rate of the network algorithm. The project would demonstrate the capability of the GNU Radio to work as a generic receiver tool, while at the same time providing packets to Wireshark as well.



In order to communicate with the Wireshark, GNU Radio will use the libpcap library, which is a C/C++ library for network traffic capture, and Wireshark uses it to capture the packets. A new block/socket will be developed inside GNU Radio in order to interact with Wireshark. On the other hand, to receive and process the WiFi packets an OFDM based receiver in GNU Radio will be used, which is developed by University of Innsbruck. As there are many OFDM codes are being written, this will help in working along those developments and integrating it into GNU Radio to make available a trans-receiver which might provide full access down to physical layer.