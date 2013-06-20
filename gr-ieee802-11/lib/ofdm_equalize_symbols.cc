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
#include <gnuradio/ieee802_11/ofdm_equalize_symbols.h>
#include <gnuradio/io_signature.h>

#include <iostream>

using namespace gr::ieee802_11;

// Phase offset correction and channel estimation
class ofdm_equalize_symbols_impl : public ofdm_equalize_symbols {

#define dout d_debug && std::cout
// Costructor to create the block
public:
ofdm_equalize_symbols_impl(bool debug) : gr::block("ofdm_equalize_symbols",
			gr::io_signature::make(1, 1, 64 * sizeof(gr_complex)),
			gr::io_signature::make(1, 1, 48 * sizeof(gr_complex))),
			d_debug(debug) {

	set_relative_rate(1);
}
//destructor of the class
~ofdm_equalize_symbols_impl(){
}
//main functions
int general_work (int noutput_items, gr_vector_int& ninput_items,
		gr_vector_const_void_star& input_items,
		gr_vector_void_star& output_items) {

	const gr_complex *in = (const gr_complex*)input_items[0];
	gr_complex *out = (gr_complex*)output_items[0];

	int noutput = noutput_items;
	int i = 0;

	std::vector<gr::tag_t> tags;
	const uint64_t nread = nitems_read(0);
// print out inputs and outputs
	dout << "SYMBOLS: input " << ninput_items[0] << "  output " << noutput_items << std::endl;
//need to read the tag provided in previous block
	while((i < ninput_items[0]) && (i < noutput)) {

		get_tags_in_range(tags, 0, nread + i * 64, nread + (i + 1) * 64 - 1,
			pmt::string_to_symbol("ofdm_start"));

		if(tags.size()) {
			index = 0;
		}

		gr_complex p = POLARITY[index];
		index++;
// linear regression
// determining the scatter plot for phase vs bits
// bit position 11, 25, 39, 53 and the polarity matrix are known (checkout with the ieee 802.11?)		
		double p1 = arg( p * in[11]);
		double p2 = arg( p * in[25] * conj(p * in[11])) + p1;
		double p3 = arg( p * in[39] * conj(p * in[25])) + p2;
		double p4 = arg(-p * in[53] * conj(p * in[39])) + p3;
// least square fit, Y = M X + C implies phase(dependent_variable) = beta(slope) * bits_index(indpendent_variable) + alpha(error)               
		double my = (p1 + p2 + p3 + p4) / 4;
		double mx = (11.0 + 25 + 39 + 53) / 4;

		double var = (((11.0 * 11.0) + (25.0 * 25.0) + (39.0 * 39.0) + (53.0 * 53.0)) / 4) - (mx * mx);
		double cov =  (( (p1 * 11) + (p2 * 25) + (p3 * 39) + (p4 * 53) ) / 4) - (mx * my);
		double beta = cov / var; // Calculating slope
		double alpha = my - beta * mx; // Calculating error
		
		int o = 0;
//Converted to 48 symbols, input is 64 and out is 48
// Compensating the phase for every bit other than the known bits according to phase determined from the lr model
		for(int n = 0; n < 64; n++) {
			if( (n == 11) || (n == 25) || (n == 32) || (n == 39) || (n == 53) || (n < 6) || ( n > 58)) {
				continue;
			} else {
				out[o] = in[n] * exp(gr_complex(0, -n * beta - alpha));
				o++;
			}
		}

		i++;
		in += 64;
		out += 48;
	}

	dout << "SYMBOLS: produced / consumed " << i << std::endl;

	consume(0, i);
	return i;
}

private:
	int          index;
	const bool   d_debug;
	static const gr_complex POLARITY[127];
};

const gr_complex ofdm_equalize_symbols_impl::POLARITY[127] = {
		 1, 1, 1, 1,-1,-1,-1, 1,-1,-1,-1,-1, 1, 1,-1, 1,
		-1,-1, 1, 1,-1, 1, 1,-1, 1, 1, 1, 1, 1, 1,-1, 1,
		 1, 1,-1, 1, 1,-1,-1, 1, 1, 1,-1, 1,-1,-1,-1, 1,
		-1, 1,-1,-1, 1,-1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,
		-1,-1, 1,-1, 1,-1, 1, 1,-1,-1,-1, 1, 1,-1,-1,-1,
		-1, 1,-1,-1, 1,-1, 1, 1, 1, 1,-1, 1,-1, 1,-1, 1,
		-1,-1,-1,-1,-1, 1,-1, 1, 1,-1, 1,-1, 1, 1, 1,-1,
		-1, 1,-1,-1,-1, 1, 1, 1,-1,-1,-1,-1,-1,-1,-1 };

ofdm_equalize_symbols::sptr
ofdm_equalize_symbols::make(bool debug) {
	return gnuradio::get_initial_sptr(new ofdm_equalize_symbols_impl(debug));
}

