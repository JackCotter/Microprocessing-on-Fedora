#include <stdio.h>

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
	
	return 0;
}
