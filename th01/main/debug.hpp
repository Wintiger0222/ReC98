extern bool mode_debug;
extern bool16 mode_test;

/// Memory info screen
/// ------------------
// Hides the graphics layer and enters a memory usage screen with some debug
// options, in a blocking way. Set [input_mem_leave] to `true` to return to
// the game.
void test_mem();

// Reactivates the graphics layer and clears the text layer.
void test_show_game();
/// ------------------
