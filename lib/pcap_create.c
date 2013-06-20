// PCAP Format Code - First trial
#include <stdio.h>
#include <stdlib.h>
#include <pcap.h>

// this stuff to be in form of struct 
rx_packet declareit

typedef struct ppi_header{
//structure of ppi header
//declare 8,16 or 32 bit values accordingly using uint8_t, uint16_t or uint32_t

}

static void pcap_create(rx_packet *rx)
	{
		//stuff to create pcap and release, for the moment explanation in blog radioplus.edublogs.org
		unsigned LengthOfPacket = 4+rx.length+2
		void *DataToDump = malloc(sizeof(ppi_header)+LengthOfPacket)//allocate space
		//add up details here
		// Create variables in allocated space and copy data to them
		ppi_header *ppi = (ppi_header *)DataToDump
		void *packet_data = DataToDump
		memcpy(packet_data, rx->data, LengthOfPacket)
		//write into file
		pcap_t *pcap_p = NULL
		const char *FileName = ""
		pcap_dumper_t *pcap_dump_open(pcap_p, FileName)	
		pcap_pkthdr *header;//it is the headeer of the PCAP File
		unsigned char *dumper //Name of the dumper or user
		header.len = sizeof(ppi_header)+LengthOfPacket
		pcap_dump(dumper,&header,DataToDump)//dumps the data

	}
