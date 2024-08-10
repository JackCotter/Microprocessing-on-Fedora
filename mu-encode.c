#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// WAV file header format
typedef struct {
    char riff[4];
    uint32_t chunk_size; //CODING STANDARDS: No variable names should include upper case letters as per Barr-C section 7.1
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

uint16_t sign (uint16_t sample) {
	// return the sign of the sample: 1 (true) if positive, 0 (false) if negative. 
	if (sample & (1 << 15)) 
	{ 				// CODING STANDARDS: Braces must appear by itself on the line below the start of the block as per Barr-C section 1.3.
		return 1;
	}
	else
	{         // CODING STANDARDS: An if statement should be terminiated with an else statement as per MISRA-C 15.7.
	}
	return 0;
}

uint16_t magnitude (uint16_t sample) {
	return sample & 0x7FFF;
}

uint8_t codeword_compression (uint16_t sample_magnitude, uint16_t sign) {
	uint16_t chord, step; // CODING STANDARDS: bitwise operations should not be performed on signed integers, use unsigned. Barr-C section 5.3.
	uint8_t codeword_tmp = 0;
	int leading_zeros = 0;

	// use CLZ assembly instruction to find the number of leading zeros
	asm volatile ("CLZ %0, %1": "=r" (leading_zeros): "r" (sample_magnitude));
	// subtract 2 leading zeros as we are dealing with a 16 bit magnitude that we only need 14bits of
	int step_shift = abs(leading_zeros - 27);
	chord = abs((leading_zeros - 26));
	// extract step value via shift and mask
	step = (sample_magnitude >> step_shift) & 0x000F;
	// combine sign, chord and step to get compressed value
	codeword_tmp = ((sign << 7) & 0x80) | ((chord << 4) & 0x70) | (step & 0x0F);

	return (uint8_t) codeword_tmp;
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

	FILE *output_file = fopen("out.wav", "wb");
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
	out_header.bits_per_sample = 8;
	out_header.byte_rate = out_header.sample_rate * out_header.num_channels; 
	out_header.block_align = out_header.num_channels; 
	out_header.data_size = out_header.data_size >> 1; 
	out_header.chunk_size = 36 + out_header.data_size;

	fwrite(&out_header, sizeof(WAVHeader), 1, output_file);

	uint32_t buffer = 0;
	int bits_in_buffer = 0;
	int byte;
	fseek(file, 0, in_header.data);
	int loopIterations = in_header.data_size >> 2;
	for(int index = 0; index < loopIterations; index++) //CODING STANDARDS: No variable name should be shorted than 3 characters, including loop counters as per Barr-C 7.1.
	{
		uint16_t byte2 = fgetc(file); //CODING STANDARDS: Whenever the width of an integer matters in a program, a fixed width data type should be used as per Barr-C 5.2.
		uint16_t byte1 = fgetc(file);
		uint16_t byte2_2 = fgetc(file);
		uint16_t byte1_2 = fgetc(file);
		// combine the 2 bytes into a 16 bit integer
		uint16_t data_point = (byte1 << 8 & 0x8000 | ((byte1 & 0x7F) << 6) | (byte2 >> 2));
		uint16_t data_point_2 = (byte1_2 << 8 & 0x8000 | ((byte1_2 & 0x7F) << 6) | (byte2_2 >> 2));
		//extract sign and magnitude of the data point
		uint16_t sig = sign(data_point);
		uint16_t mag = magnitude(data_point);
		uint16_t sig_2 = sign(data_point_2);
		uint16_t mag_2 = magnitude(data_point_2);
		//compress
		uint8_t output_data_point = codeword_compression(mag, sig);
		uint8_t output_data_point_2 = codeword_compression(mag_2, sig_2);
		//write to output file
		fwrite(&output_data_point, sizeof(output_data_point), 1, output_file);
		fwrite(&output_data_point_2, sizeof(output_data_point_2), 1, output_file);
	}
	fclose(output_file);
	fclose(file);
	
	return 0;
}
