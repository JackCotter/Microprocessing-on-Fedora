#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// WAV file header format
typedef struct {
    char riff[4];
    uint32_t chunkSize;
    char wave[4];
    char fmt[4];
    uint32_t subChunk1Size;
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitsPerSample;
    uint32_t data;
    uint32_t dataSize;
} WAVHeader;

int16_t sign (int16_t sample) {
	//return the sign of the sample: 1 (true) if positive, 0 (false) if negative. 
	if (sample & 1 << 15) {
		return 1;
	}
	return 0;
}

int16_t magnitude (int16_t sample) {
	return sample & 0x7FFF;
}

int8_t codeword_compression (int16_t sample_magnitude, int16_t sign) {
	int16_t chord, step;
	int8_t codeword_tmp = 0;
	printf("sign %x", sign & 0xFFFF);
	printf("mag %x\n", sample_magnitude & 0xFFFF);

	if (sample_magnitude & (1 << 12)) {
		//12th bit is set therefore 8th chord
		chord = 0x7;
		step = (sample_magnitude >> 8) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 11)) {
		chord = 0x6;
		step = (sample_magnitude >> 7) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 10)) {
		chord = 0x5;
		step = (sample_magnitude >> 6) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 9)) {
		chord = 0x4;
		step = (sample_magnitude >> 5) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 8)) {
		chord = 0x3;
		step = (sample_magnitude >> 4) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 7)) {
		chord = 0x2;
		step = (sample_magnitude >> 3) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 6)) {
		chord = 0x1;
		step = (sample_magnitude >> 2) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	if (sample_magnitude & (1 << 5)) {
		chord = 0x0;
		step = (sample_magnitude >> 1) & 0xF;
		codeword_tmp = (sign << 7) | (chord << 4) | step;
		return (int8_t) codeword_tmp;
	}
	return 0;
}

int main(int argc, char *argv[]) {
	if (argc != 2) {
		printf("Usage: %s <path/to/wav/file>", argv[0]);
		return 1;
	}

	FILE* file = fopen(argv[1], "rb");
	if (!file) {
		printf("Failed to open file");
	}

	// open the output file for writing
	FILE *output_file = fopen("out.wav", "wb");
	if (!output_file) {
		fprintf(stderr, "Error opening output file\n");
		fclose(file);
		return 0;
	}

	// read and modify the WAV file header
	WAVHeader in_header;
	WAVHeader out_header;

	fread(&in_header, sizeof(WAVHeader), 1, file);
	// make a copy of the input header as it will be helpful in reading file
	out_header = in_header;

	// Check if the input file is a valid WAV file
	if (memcmp(in_header.riff, "RIFF", 4) != 0 || memcmp(in_header.wave, "WAVE", 4) != 0) {
		fprintf(stderr, "Invalid WAV file\n");
		fclose(file);
		fclose(output_file);
		return 0;
	}
	// alter header fields for compressed data
	out_header.bitsPerSample = 8;
	out_header.byteRate = out_header.sampleRate * out_header.numChannels; // this calculation is sampleRate * numChannels * (bitsPerSample / 8) simplfied for 8 bit sample rate
	out_header.blockAlign = out_header.numChannels; // this calculation is numChannels * bitsPerSample / 8 simplified for 8 bit sample rate
	out_header.dataSize = out_header.dataSize / 2; //this can be reorganized to remove direct dependancies
	out_header.chunkSize = 36 + out_header.dataSize;

	fwrite(&out_header, sizeof(WAVHeader), 1, output_file);

	// reading logic will need to be changed
	uint32_t buffer = 0;
	int bits_in_buffer = 0;
	int byte;
	fseek(file, 0, in_header.data);
	printf("%d", in_header.data);
	for(int i = 0; i < in_header.dataSize; i++) {
		//read 2 bytes 1 byte at a time
		int16_t byte2 = fgetc(file);
		int16_t byte1 = fgetc(file);
		// combine the 2 bytes into a 16 bit integer
		int16_t data_point = (byte1 << 8 & 0x8000 | ((byte1 & 0x7F) << 6) | (byte2 >> 2));
		printf("input: %x\n", data_point & 0xFFFF);
		//extract sign and magnitude of the data point
		int16_t sig = sign(data_point);
		int16_t mag = magnitude(data_point);
		//compress
		int8_t output_data_point = codeword_compression(mag, sig);
		//write to output file
		printf("%x\n", output_data_point & 0xFF);
		fwrite(&output_data_point, sizeof(output_data_point), 1, output_file);
	}
	fclose(output_file);
	fclose(file);
	
	return 0;
}
