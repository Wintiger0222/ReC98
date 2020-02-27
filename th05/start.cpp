#define ES_SCORE 0

#define clear_score \
	for(int i = 0; i < SCORE_DIGITS; i++) { \
		resident->score_last.digits[i] = 0; \
		resident->score_highest.digits[i] = 0; \
		for(int j = 0; j < MAIN_STAGE_COUNT; j++) { \
			resident->stage_score[j].digits[i] = 0; \
		} \
	}

#define start_exec \
		clear_score; \
		main_cdg_free(); \
		cfg_save(); \
		snd_kaja_func(KAJA_SONG_FADE, 10); \
		game_exit(); \
		execl(aMain, aMain, 0, 0); \

#define aDeb  (char*)aDeb
#define aMain (char*)aMain

void start_game(void) {
	resident->end_sequence = ES_SCORE;
	resident->demo_num = 0;
	resident->stage = 0;
	resident->credit_lives = resident->cfg_lives;
	resident->credit_bombs = resident->cfg_bombs;
	if(!playchar_menu()) {
		clear_score;
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

void start_extra(void) {
	resident->demo_num = 0;
	resident->stage = STAGE_EXTRA;
	resident->credit_lives = 3;
	resident->credit_bombs = 3;
	if(!playchar_menu()) {
		start_exec;
	}
}

void start_demo(void) {
	resident->end_sequence = ES_SCORE;
	resident->stage = 0;
	resident->credit_lives = 3;
	resident->credit_bombs = 3;
	resident->demo_num++;
	if(resident->demo_num > 4) {
		resident->demo_num = 1;
	}
	if(key_det.v & (INPUT_LEFT | INPUT_RIGHT)) {
		if(extra_playable_with[PLAYCHAR_REIMU] || extra_playable_with[PLAYCHAR_MARISA] || extra_playable_with[PLAYCHAR_MIMA] || extra_playable_with[PLAYCHAR_YUUKA] ) {
			resident->demo_num = 5;
		} else {
			resident->demo_num = 0;
			return;
		}
	}
	switch(resident->demo_num) {
		case 1:
			resident->playchar = PLAYCHAR_REIMU;
			resident->demo_stage = 3;
			break;
		case 2:
			resident->playchar = PLAYCHAR_MARISA;
			resident->demo_stage = 1;
			break;
		case 3:
			resident->playchar = PLAYCHAR_MIMA;
			resident->demo_stage = 2;
			break;
		case 4:
			resident->playchar = PLAYCHAR_YUUKA;
			resident->demo_stage = 4;
			break;
		case 5:
			resident->playchar = PLAYCHAR_MIMA;
			resident->demo_stage = 6;
			snd_kaja_func(KAJA_SONG_FADE, 8);
			break;
	}
	for(int i = 0; i < 8; i++) {
		resident->score_last.digits[i] = 0;
		resident->score_highest.digits[i] = 0;
	}
	main_cdg_free();
	cfg_save();
	palette_black_out(1);
	execl(aMain, aMain, 0, 0);
}