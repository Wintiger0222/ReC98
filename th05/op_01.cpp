/* ReC98
 * -----
 * Code segment #1 of TH05's OP.EXE
 */

extern "C" {

#include "platform.h"
#include "th01/ranks.h"
#include "th04/formats/scoredat.h"
#include "th05/player/chars.h"

#include "th05/th05.hpp"
/*
extern int pascal playchar_menu(void);
void main_cdg_free(void);
extern void pascal cfg_save(void);
extern void pascal game_exit(void);
extern void pascal cdg_freeall(void);
*/
//const char *aMain = "main";
//const char *aDeb = "deb";


scoredat_section_t hi;
scoredat_section_t hi2;
static uint8_t scoredat_unused;

unsigned char hiscore_rank;
unsigned char cleared_with[PLAYCHAR_COUNT][RANK_COUNT];
bool extra_unlocked;
static uint8_t unused_2;
unsigned char playchar_menu_sel;
static uint8_t unused_1;
unsigned char rank;
static uint8_t unused_0[4];
bool extra_playable_with[PLAYCHAR_COUNT];
bool selectable_with[PLAYCHAR_COUNT];

// #include "th05/start.cpp"
/*
void main_cdg_free(void) {
	cdg_freeall();
}*/
}
