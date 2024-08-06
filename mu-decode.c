#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// WAV file header format
typedef struct {
    char riff[4];
    uint32_t chunk_size;
    char wave[4];
    char fmt[4];
    uint32_t sub_chunk_1_size;
    uint16_t audio_format;
    uint16_t num_channels;
    uint32_t sample_rate;
    uint32_t byte_rate;
    uint16_t block_align;
    uint16_t bits_per_sample;
    uint32_t data;
    uint32_t data_size;
} WAVHeader;

int8_t sign (int8_t sample) {
	//return the sign of the sample: 1 (true) if positive, 0 (false) if negative. 
	if (sample & (1 << 7)) 
	{
		return 1;
	}
	else
	{
	}
	return 0;
}

int8_t magnitude (int8_t sample) {
	return sample & 0x7F;
}

int16_t codeword_expansion (int8_t sample_magnitude, int8_t sign) {
	int16_t chord, step, codeword_tmp;

	if ((sample_magnitude & (0x7 << 4)) == 0x70) 
	{
		chord = 0x1 << 12;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 8 | 0x1 << 7) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	if ((sample_magnitude & (0x6 << 4)) == 0x60) 
	{
		chord = 0x1 << 11;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 7 | 0x1 << 6) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	} 
	else
	{
	}
	if ((sample_magnitude & (0x5 << 4)) == 0x50) 
	{
		chord = 0x1 << 10;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 6 | 0x1 << 5) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	} 
	else
	{
	}
	if ((sample_magnitude & (0x4 << 4)) == 0x40) 
	{
		chord = 0x1 << 9;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 5 | 0x1 << 4) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	if ((sample_magnitude & (0x3 << 4)) == 0x30) 
	{
		chord = 0x1 << 8;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 4 | 0x1 << 3) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	if ((sample_magnitude & (0x2 << 4)) == 0x20) 
	{
		chord = 0x1 << 7;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 3 | 0x1 << 2) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	if ((sample_magnitude & (0x1 << 4)) == 0x10) 
	{
		chord = 0x1 << 6;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 2 | 0x1 << 1) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	if (sample_magnitude & (0x7 << 4) == 0) 
	{
		chord = 0x1 << 5;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 1 | 0x1) << 2;
	       	return (int16_t) codeword_tmp; // Works with codeword_tmp as it is already 16 bits
	}
	else
	{
	}
	return 0;
}

int main(int argc, char *argv[]) {
	if (argc != 2) 
	{
		printf("Usage: %s <path/to/wav/file>", argv[0]);
		return 1;
	}
	else
	{
	}

	FILE* file = fopen(argv[1], "rb");
	if (!file) 
	{
		printf("Failed to open file");
	}
	else
	{
	}

	// open the output file for writing
	FILE *output_file = fopen("decompressed_out.wav", "wb");
	if (!output_file) 
	{
		fprintf(stderr, "Error opening output file\n");
		fclose(file);
		return 0;
	}
	else
	{
	}

	// read and modify the WAV file header
	WAVHeader in_header;
	WAVHeader out_header;

	fread(&in_header, sizeof(WAVHeader), 1, file);
	// make a copy of the input header as it will be helpful in reading file
	out_header = in_header;

	// Check if the input file is a valid WAV file
	if (memcmp(in_header.riff, "RIFF", 4) != 0 || memcmp(in_header.wave, "WAVE", 4) != 0) 
	{
		fprintf(stderr, "Invalid WAV file\n");
		fclose(file);
		fclose(output_file);
		return 0;
	}
	else
	{
	}
	// alter header fields for compressed data
	out_header.bits_per_sample = 16;
	out_header.byte_rate = out_header.sample_rate * out_header.num_channels << 1;
	out_header.block_align = out_header.num_channels << 1; 
	out_header.data_size = out_header.data_size << 1; 
	out_header.chunk_size = 36 + out_header.data_size;

	fwrite(&out_header, sizeof(WAVHeader), 1, output_file);

	// reading logic will need to be changed
	int loop_limit = in_header.data_size >> 1;
	fseek(file, 0, in_header.data);
	for(int index = 0; index < loop_limit; index++)  
	{
		int8_t byte = fgetc(file);
		int8_t byte_2 = fgetc(file);

		int8_t sig = sign(byte);
		int8_t mag = magnitude(byte);
		int8_t sig_2 = sign(byte_2);
		int8_t mag_2 = magnitude(byte_2);
		//compress
		int16_t data_point = codeword_expansion(mag, sig);
		int16_t data_point_2 = codeword_expansion(mag_2, sig_2);
		//write to output file
		fwrite(&data_point, sizeof(data_point), 1, output_file);
		fwrite(&data_point_2, sizeof(data_point_2), 1, output_file);
	}
	fclose(output_file);
	fclose(file);
	
	return 0;
}
