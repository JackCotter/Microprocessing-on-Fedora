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

uint8_t sign (uint8_t sample) {
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

uint8_t magnitude (uint8_t sample) {
	return sample & 0x7F;
}

uint16_t codeword_expansion (uint8_t sample_magnitude, uint8_t sign) {
	uint16_t chord, step, val_tmp, codeword_tmp;
	//get step
	step = sample_magnitude & 0x0F;
	//get chord
	chord = sample_magnitude & 0x70;
	//create value to be shifted
	val_tmp = (0x0020) | (step << 1) | (0x0001);
	//create and return expanded codeword
	return codeword_tmp = (sign << 15) | (val_tmp << (chord + 2));
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
		uint8_t byte = fgetc(file);
		uint8_t byte_2 = fgetc(file);

		uint8_t sig = sign(byte);
		uint8_t mag = magnitude(byte);
		uint8_t sig_2 = sign(byte_2);
		uint8_t mag_2 = magnitude(byte_2);
		//compress
		uint16_t data_point = codeword_expansion(mag, sig);
		uint16_t data_point_2 = codeword_expansion(mag_2, sig_2);
		//write to output file
		fwrite(&data_point, sizeof(data_point), 1, output_file);
		fwrite(&data_point_2, sizeof(data_point_2), 1, output_file);
	}
	fclose(output_file);
	fclose(file);
	
	return 0;
}
