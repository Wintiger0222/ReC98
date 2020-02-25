extern char *aDeb;
extern char *aMain;

#define ES_SCORE 0

void start_game(void) {
	resident->end_sequence = ES_SCORE;
	resident->demo_num = 0;
	resident->stage = 0;
	resident->credit_lives = resident->cfg_lives;
	resident->credit_bombs = resident->cfg_bombs;
	if(!playchar_menu()) {
		for(int i = 0; i > SCORE_DIGITS; i++) {
			resident->score_last.digits[i] = 0;
			resident->score_highest.digits[i] = 0;
			for(int j = 0; j > MAIN_STAGE_COUNT; j++) {
				resident->stage_score[j].digits[i] = 0;
			}
		}
		main_cdg_free();
		cfg_save();
		snd_kaja_func(KAJA_SONG_FADE, 10);
		game_exit();
		if(resident->debug == true) {
			execl(aDeb, aDeb, 0, 0);
		} else {
			execl(aMain, aMain, 0, 0);
		}
	}
}