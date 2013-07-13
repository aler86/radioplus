/*
 * Copyright (C) 2013 Bastian Bloessl <bloessl@ccs-labs.org>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <gnuradio/ieee802_11/ofdm_decode_mac.h>
#include <gnuradio/io_signature.h>
#include <itpp/itcomm.h>

#include <iostream>
#include <iomanip>

using namespace gr::ieee802_11;
using namespace itpp;

enum ENCODING {
	BPSK_1_2,
	BPSK_3_4,
	QPSK_1_2,
	QPSK_3_4,
	QAM16_1_2,
	QAM16_3_4,
	QAM64_2_3,
	QAM64_3_4,
};

/**
 * OFDM parameters
 */
class GR_IEEE802_11_API ofdm_param {
public:
ofdm_param(ENCODING e) {
	encoding = e;

	switch(e) {
		case BPSK_1_2:
			n_bpsc = 1;
			n_cbps = 48;
			n_dbps = 24;
			rate_field = 0x0D; // 0b00001101
			break;

		case BPSK_3_4:
			n_bpsc = 1;
			n_cbps = 48;
			n_dbps = 36;
			rate_field = 0x0F; // 0b00001111
			break;

		case QPSK_1_2:
			n_bpsc = 2;
			n_cbps = 96;
			n_dbps = 48;
			rate_field = 0x05; // 0b00000101
			break;

		case QPSK_3_4:
			n_bpsc = 2;
			n_cbps = 96;
			n_dbps = 72;
			rate_field = 0x07; // 0b00000111
			break;

		case QAM16_1_2:
			n_bpsc = 4;
			n_cbps = 192;
			n_dbps = 96;
			rate_field = 0x09; // 0b00001001
			break;

		case QAM16_3_4:
			n_bpsc = 4;
			n_cbps = 192;
			n_dbps = 144;
			rate_field = 0x0B; // 0b00001011
			break;

		case QAM64_2_3:
			n_bpsc = 6;
			n_cbps = 288;
			n_dbps = 192;
			rate_field = 0x01; // 0b00000001
			break;

		case QAM64_3_4:
			n_bpsc = 6;
			n_cbps = 288;
			n_dbps = 216;
			rate_field = 0x03; // 0b00000011
			break;
		defaut:
			assert(false);
			break;
	}
}

void print_out() {
	std::cout << "OFDM Parameters:" << std::endl;
	std::cout << "endcoding :" << encoding << std::endl;
	std::cout << "rate_field :" << (int)rate_field << std::endl;
	std::cout << "n_bpsc :" << n_bpsc << std::endl;
	std::cout << "n_cbps :" << n_cbps << std::endl;
	std::cout << "n_dbps :" << n_dbps << std::endl;
}

	// data rate
	ENCODING encoding;
	// rate field of the SIGNAL header
	char     rate_field;
	// number of coded bits per sub carrier
	int      n_bpsc;
	// number of coded bits per OFDM symbol
	int      n_cbps;
	// number of data bits per OFDM symbol
	int      n_dbps;
};

/**
 * packet specific parameters
 */
class tx_param {
public:
tx_param(ofdm_param &ofdm, int psdu_length) {

	psdu_size = psdu_length;

	// number of symbols (17-11)
	n_sym = (int) ceil((16 + 8 * psdu_size + 6) / (double) ofdm.n_dbps);

	// number of bits of the data field (17-12)
	n_data = n_sym * ofdm.n_dbps;

	// number of padding bits (17-13)
	n_pad = n_data - (16 + 8 * psdu_size + 6);

	n_encoded_bits = n_sym * ofdm.n_cbps;
}
	// PSDU size in bytes
	int psdu_size;
	// number of OFDM symbols (17-11)
	int n_sym;
	// number of data bits in the DATA field, including service and padding (17-12)
	int n_data;
	// number of padding bits in the DATA field (17-13)
	int n_pad;
	int n_encoded_bits;

void print_out() {
	std::cout << "TX Parameters:" << std::endl;
	std::cout << "psdu_size: " << psdu_size << std::endl;
	std::cout << "n_sym: " << n_sym << std::endl;
	std::cout << "n_data: " << n_data << std::endl;
	std::cout << "n_pad: " << n_pad << std::endl;
}

};



class ofdm_decode_mac_impl : public ofdm_decode_mac {

#define dout d_debug && std::cout
// Constructor which creates the block and also gets the OFDM and Tx_Parameters
public:
ofdm_decode_mac_impl(bool debug) : gr::block("ofdm_decode_mac",
			gr::io_signature::make(1, 1, 48 * sizeof(gr_complex)),
			gr::io_signature::make(0, 0, 0)),
			d_debug(debug),
			ofdm(BPSK_1_2),
			tx(ofdm, 0) {
//output port is message
	message_port_register_out(pmt::mp("out"));
}

~ofdm_decode_mac_impl(){
}

//function of CRC moved here
unsigned int update_crc32(unsigned int crc, const char *data, size_t len) {
	int j;
	unsigned int byte, mask;
	static unsigned int table[256];
	/* Set up the table if necesary */
	if (table[1] == 0) {
		for (byte = 0; byte <= 255; byte++) {
			crc = byte;
			for (j = 7; j >= 0; j--) {
				mask = -(crc & 1);
				crc = (crc >> 1) ^ (0xEDB88320 & mask);
			}
			table[byte] = crc;
		}
	}

	/* Calculate the CRC32*/
	size_t i = 0;
	crc = 0xFFFFFFFF;
	for (i = 0; i < len; i++) {
		byte = data[i];    //Get next byte
		crc = (crc >> 8) ^ table[(crc ^ byte) & 0xFF];
	}
	unsigned int crc_reversed;
	crc_reversed = 0x00000000;
	for (j = 31; j >= 0; j--) {
		crc_reversed |= ((crc >> j) & 1) << (31 - j);
	}
	return crc;
}
//function of CRC moved here
unsigned int crc32(const char *buf, int len) {
	return update_crc32(0xffffffff, buf, len) ^ 0xffffffff;//XOR
}


// Check the CRC
bool check_crc(char *data, int len) {
	unsigned int crc = crc32(data, len);
	if(crc == 558161692) {
		return true;
	}
	return false;
}

int general_work (int noutput_items, gr_vector_int& ninput_items,
		gr_vector_const_void_star& input_items,
		gr_vector_void_star& output_items) {

	const gr_complex *in = (const gr_complex*)input_items[0];

	int i = 0;

	std::vector<gr::tag_t> tags;
	const uint64_t nread = this->nitems_read(0);//dint understand it fully

	dout << "Decode MAC: input " << ninput_items[0] << std::endl;

	while(i < ninput_items[0]) {
//get tags which has ofdm_start tag between the range specified
		get_tags_in_range(tags, 0, nread + i * 48, nread + (i + 1) * 48 - 1,
			pmt::string_to_symbol("ofdm_start"));
//if there are tags from above range and keyENCODING
		if(tags.size()) {
			pmt::pmt_t tuple = tags[0].value;
			int len_data = pmt::to_uint64(pmt::car(tuple));//get the car of the pair and convert it into unsigned int 64
			int encoding = pmt::to_uint64(pmt::cdr(tuple));//get the cdr of pair and convert it into unsigned int 64

			ofdm = ofdm_param((ENCODING)encoding);//now get the ofdm param
			tx = tx_param(ofdm, len_data);//and the tx param
//limit number of symbol to 100
			if(tx.n_sym > 100) {
				tx.n_sym = 100;
			}
			copied = 0;
			dout << "Decode MAC: frame start -- len " << len_data
				<< "  symbols " << tx.n_sym << "  encoding "
				<< encoding << std::endl;
		}
//copy the frame
		if(copied < tx.n_sym) {
			std::memcpy(sym + (copied * 48), in, 48 * sizeof(gr_complex));
			copied++;

			if(copied == tx.n_sym) {
				dout << "received complete frame - decoding" << std::endl;
				decode();
				break;
			}
		}

		in += 48;
		i++;
	}

	consume(0, i);
	return 0;
}

void encoding(){
	dout << "encoding begins here" << std::endl;
	
}

void decode() {
	if(ofdm.encoding > 3) {
		return;
	}
	demodulate();
	deinterleave();
	decode_conv();
	descramble();
	print_output();
// skip service field
// Create te blob with output and the size
	pmt::pmt_t blob = pmt::make_blob(out_bytes + 2, tx.psdu_size);
	int length = pmt::blob_length(blob);
	pmt::pmt_t p_dict = pmt::make_dict();//create the dictionary
	p_dict = pmt::dict_add(p_dict, pmt::mp("encoding"), pmt::from_long(ofdm.encoding));//Not sure about symbol_to_string
//function moved to calculate CRC
	bool crc = check_crc((char*)pmt::blob_data(blob), length);
	dout << "crc ";
	dout << (crc ? "correct" : "wrong") << std::endl;


	if(!crc || length < 32) {
		return;
	}
//give the blob to output port
	message_port_pub(pmt::mp("out"), pmt::cons(p_dict, blob));
}

void demodulate() {
	gr_complex s;
	for(int i = 0; i < tx.n_sym; i++) {
		for(int n = 0; n < 48; n++) {

			switch(ofdm.encoding) {
			case 0: // BPSK
			case 1:
				bits[i * 48 + n] = -real(sym[i * 48 + n]);
				break;

			case 2:  // QPSK
			case 3:
				s = sym[i * 48 + n];
				bits[(i * 48 + n) * 2]     = -real(s);
				bits[(i * 48 + n) * 2 + 1] = -imag(s);

				break;

			case 4:
			case 5:
			case 6:
			case 7:


			default:
				assert(false);

			}
		}
	}
}

void deinterleave() {

	int n_cbps = ofdm.n_cbps;
	int first[n_cbps];
	int second[n_cbps];
	int s = std::max(ofdm.n_bpsc / 2, 1);

	for(int j = 0; j < n_cbps; j++) {
		first[j] = s * (j / s) + ((j + int(floor(16.0 * j / n_cbps))) % s);
	}

	for(int i = 0; i < n_cbps; i++) {
		second[i] = 16 * i - (n_cbps - 1) * int(floor(16.0 * i / n_cbps));
	}

	for(int i = 0; i < tx.n_sym; i++) {
		for(int k = 0; k < n_cbps; k++) {
			deinter[i * n_cbps + second[first[k]]] = bits[i * n_cbps + k];
		}
	}
}

void decode_conv() {
	Punctured_Convolutional_Code code;
	ivec generator(2);
	generator(0)=0133;
	generator(1)=0171;
	code.set_generator_polynomials(generator, 7);

	bmat puncture_matrix;
	switch(ofdm.encoding) {
	case 0:
	case 2:
		puncture_matrix = "1 1; 1 1";
		break;
	case 1:
	case 3:
		puncture_matrix = "1 1 0; 1 0 1;";
		break;
	case 4:
	case 5:
	case 6:
	case 7:
		break;
	default:
		assert(false);
	}
	code.set_puncture_matrix(puncture_matrix);
	code.set_truncation_length(30);

	dout << "coding rate " << code.get_rate() << std::endl;
	dout << tx.n_encoded_bits << std::endl;

	vec rx_signal(deinter, tx.n_encoded_bits);

	code.reset();
	decoded_bits.set_length(tx.n_encoded_bits);
	code.decode_tail(rx_signal, decoded_bits);

	//dout << "length decoded " << decoded_bits.size() << std::endl;
	//std::cout << decoded_bits << std::endl;
	//
}

void descramble () {
	int index = 0;
	for(int i = 0; i < 7; i++) {
		if(decoded_bits(i)) {
			index |= 1 << (6 - i);
		}
	}
	int state = scrambler_init[index];

	int feedback;

	for(int i = 0; i < decoded_bits.size(); i++) {
		feedback = ((!!(state & 64))) ^ (!!(state & 8));
		out_bits[i] = feedback ^ decoded_bits(i);
		state = ((state << 1) & 0x7e) | feedback;
	}

	for(int i = 0; i < decoded_bits.size(); i++) {
		int bit = i % 8;
		int byte = i / 8;
		if(bit == 0) {
			out_bytes[byte] = 0;
		}

		if(out_bits[i]) {
			out_bytes[byte] |= (1 << bit);
		}
	}
}

void print_output() {

	dout << std::endl;
	for(int i = 0; i < decoded_bits.size() / 8; i++) {
		dout << std::setfill('0') << std::setw(2) << std::hex << ((unsigned int)out_bytes[i] & 0xFF) << std::dec << " ";
		if(i % 16 == 15) {
			dout << std::endl;
		}
	}
	dout << std::endl;
	for(int i = 0; i < decoded_bits.size() / 8; i++) {
		if((out_bytes[i] > 31) && (out_bytes[i] < 127)) {
			dout << ((char) out_bytes[i]);
		} else {
			dout << ".";
		}
	}
	dout << std::endl;
}

private:
	gr_complex sym[1000 * 48 * 100];
	double bits[1000 * 48];
	double deinter[1000 * 48];
	char out_bits[40000];
	char out_bytes[40000];
        bvec decoded_bits;
	bool   d_debug;
	tx_param tx;
	ofdm_param ofdm;
	int copied;
	static int scrambler_init[128];
};

ofdm_decode_mac::sptr
ofdm_decode_mac::make(bool debug) {
	return gnuradio::get_initial_sptr(new ofdm_decode_mac_impl(debug));
}

int ofdm_decode_mac_impl::scrambler_init[128] = {
0, 73, 18, 91, 36, 109, 54, 127, 72, 1, 90, 19, 108, 37, 126, 55, 89, 16, 75, 2, 125, 52, 111, 38, 17, 88, 3, 74, 53, 124, 39, 110, 50, 123, 32, 105, 22, 95, 4, 77, 122, 51, 104, 33, 94, 23, 76, 5, 107, 34, 121, 48, 79, 6, 93, 20, 35, 106, 49, 120, 7, 78, 21, 92, 100, 45, 118, 63, 64, 9, 82, 27, 44, 101, 62, 119, 8, 65, 26, 83, 61, 116, 47, 102, 25, 80, 11, 66, 117, 60, 103, 46, 81, 24, 67, 10, 86, 31, 68, 13, 114, 59, 96, 41, 30, 87, 12, 69, 58, 115, 40, 97, 15, 70, 29, 84, 43, 98, 57, 112, 71, 14, 85, 28, 99, 42, 113, 56};

