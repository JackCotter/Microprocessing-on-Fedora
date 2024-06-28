#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// WAV file header format
typedef struct {
    char riff[4];
    uint32_t fileSize;
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

void initWAVHeader(WAVHeader *wh, uint16_t bitsPerSample){
    memcpy(wh->riff, "RIFF", 4);
    wh->fileSize = 0; // Placeholder, should be set later
    memcpy(wh->wave, "WAVE", 4);
    
    // Initialize the 'fmt ' sub-chunk
    memcpy(wh->fmt, "fmt ", 4);
    wh->subChunk1Size = 16; // PCM
    wh->audioFormat = 1;    // PCM format
    wh->numChannels = 1;
    wh->sampleRate = 8000;
    wh->bitsPerSample = bitsPerSample;

    wh->byteRate = wh->sampleRate * wh->numChannels * wh->bitsPerSample / 8;
    wh->blockAlign = wh->numChannels * wh->bitsPerSample / 8;

    // Initialize the 'data' sub-chunk
    memcpy(wh->data, "data", 4);
    wh->dataSize = 0; // Placeholder, should be set later
}

uint16_t sign (int8_t sample) {
	//return the sign of the sample: 1 (true) if positive, 0 (false) if negative. 
	if (sample & 1 << 7) {
		return 1;
	}
	return 0;
}

uint16_t magnitude (int8_t sample) {
	return sample & 0x7F;
}

uint16_t codeword_expansion (int16_t sample_magnitude, int16_t sign) {
	uint16_t chord, step, codeword_tmp;
	codeword_tmp = 0x0000;

	if (sample_magnitude & (0x7 << 4)) {
		chord = 0x1 << 12;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 8 | 0x1 << 7) << 2;
	       	return (int16_t) codeword_tmp;
	}
	if (sample_magnitude & (0x6 << 4)) {
		chord = 0x1 << 11;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 7 | 0x1 << 6) << 2;
	       	return (int16_t) codeword_tmp;
	} 
	if (sample_magnitude & (0x5 << 4)) {
		chord = 0x1 << 10;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 6 | 0x1 << 5) << 2;
	       	return (int16_t) codeword_tmp;
	} 
	if (sample_magnitude & (0x4 << 4)) {
		chord = 0x1 << 9;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 5 | 0x1 << 4) << 2;
	       	return (int16_t) codeword_tmp;
	}
	if (sample_magnitude & (0x3 << 4)) {
		chord = 0x1 << 8;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 4 | 0x1 << 3) << 2;
	       	return (int16_t) codeword_tmp;
	}
	if (sample_magnitude & (0x2 << 4)) {
		chord = 0x1 << 7;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 3 | 0x1 << 2) << 2;
	       	return (int16_t) codeword_tmp;
	}
	if (sample_magnitude & (0x1 << 4)) {
		chord = 0x1 << 6;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 2 | 0x1 << 1) << 2;
	       	return (int16_t) codeword_tmp;
	}
	if (sample_magnitude & (0x7 << 4) == 0) {
		chord = 0x1 << 5;
		step = (sample_magnitude & 0xF);
	       	codeword_tmp = (sign << 15) | (chord | step << 1 | 0x1) << 2;
	       	return (int16_t) codeword_tmp;
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
	FILE *output_file = fopen("decompressed_out.wav", "wb");
	if (!output_file) {
		printf("Error opening output file\n");
		fclose(file);
		return 0;
	}

	// read and modify the WAV file header
	WAVHeader out_header;
	initWAVHeader(&out_header, 16);

	fwrite(&out_header, sizeof(WAVHeader), 1, output_file);

	fseek(file, 0, SEEK_SET);
	uint32_t data_size = 0;
	while(!feof(file)){
		uint8_t byte = fgetc(file);
		uint16_t sig = sign(byte);
		uint16_t mag = magnitude(byte);
		uint16_t data_point = codeword_expansion(mag, sig);
		fwrite(&data_point, sizeof(data_point), 1, output_file);
		data_size++;
	}
	//write datasize to header
	printf("%d", data_size);
	fseek(output_file, 40, SEEK_SET);
	fwrite(&data_size, sizeof(data_size), 1, output_file);
	fseek(output_file, 4, SEEK_SET);
	data_size += 36;
	fwrite(&data_size, sizeof(data_size), 1, output_file);
	fclose(output_file);
	fclose(file);
	
	return 0;
}
