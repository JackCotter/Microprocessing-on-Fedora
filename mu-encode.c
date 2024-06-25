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
    char data[4];
    uint32_t dataSize;
} WAVHeader;

int sign (int sample) {
	//return the sign of the sample: 1 (true) if positive, 0 (false) if negative. 
	if (sample < 0) {
		return 0;
	}
	return 1;
}

int magnitude (int sample) {
	if (sample < 0) {
		return -1 * sample;
	}
	return sample;
}

int codeword_compression ( unsigned int sample_magnitude, int sign) {
	int chord, step, codeword_tmp;

	if (sample_magnitude & (1 << 12)) {
		//12th bit is set therefore 8th chord
		chord = 0x7;
		step = (sample_magnitude >> 8) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 11)) {
		chord = 0x6;
		step = (sample_magnitude >> 7) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 9)) {
		chord = 0x4;
		step = (sample_magnitude >> 5) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 8)) {
		chord = 0x3;
		step = (sample_magnitude >> 4) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 7)) {
		chord = 0x2;
		step = (sample_magnitude >> 3) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 6)) {
		chord = 0x1;
		step = (sample_magnitude >> 2) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
	}
	if (sample_magnitude & (1 << 5)) {
		chord = 0x0;
		step = (sample_magnitude >> 1) & 0xF;
		codeword_tmp = (sign << 7) & (chord << 4) & step;
		return (char) codeword_tmp;
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

	uint32_t buffer = 0;
	int bits_in_buffer = 0;
	int byte;
	while ((byte = fgetc(file)) != EOF) {
		buffer = (buffer << 8) | (byte & 0xFF); //add a new byte to buffer
		bits_in_buffer += 8;

		while (bits_in_buffer >= 14) {
			uint32_t fourteen_bits = buffer & 0x3FFF;
			buffer = buffer >> 14;
			// Perform encoding here
			//
			// Debug print
			printf("%u\n", fourteen_bits);

			bits_in_buffer -= 14;
		}
	}
	
	return 0;
}
