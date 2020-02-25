#ifndef _IGUARD_TH04_SCORE_H
#define _IGUARD_TH04_SCORE_H
#include "th02/score.h"

typedef union {
	unsigned char continues_used;
	unsigned char digits[SCORE_DIGITS];
} score_lebcd_t;

extern unsigned char extends_gained;
#endif