static const int ORB_W = 32;
static const int ORB_H = 32;

static const int ORB_LEFT_MIN = (PLAYFIELD_LEFT);
static const int ORB_LEFT_MAX = (PLAYFIELD_RIGHT - ORB_W);
static const int ORB_TOP_MIN = (PLAYFIELD_TOP);
static const int ORB_TOP_MAX = (PLAYFIELD_BOTTOM - ORB_H);

static const int ORB_LEFT_START = (ORB_LEFT_MAX -  8);
static const int  ORB_TOP_START = ( ORB_TOP_MAX - 88);

extern int  orb_cur_left,  orb_cur_top;
extern int orb_prev_left, orb_prev_top;
extern bool16 orb_in_portal;

/// Physics
/// -------
#pragma option -b
enum orb_velocity_x_t {
	OVX_0 = 0,
	OVX_4_LEFT = 1,
	OVX_4_RIGHT = 2,
	OVX_8_LEFT = 3,
	OVX_8_RIGHT = 4,
};

enum orb_force_t {
	OF_BOUNCE_FROM_GROUND = 0,
	OF_BOUNCE_FROM_TOP = 1,
	OF_SHOT = 2,
	OF_IMMEDIATE = 3, // new force passed directly in [immediate]
};
#pragma option -b.

// Initial value of the current force acting on the orb
extern double orb_force;

// Number of frames that [orb_force] has been acting on the orb
extern int orb_force_frame;

extern orb_velocity_x_t orb_velocity_x;
extern double orb_velocity_y;

// Applies a new force of the given type onto the orb. Sets [orb_force], and
// resets [orb_force_frame].
void orb_force_new(double immediate, orb_force_t force);

// Updates [orb_velocity_y] with the currently active force, and returns the
// orb's velocity for this frame, in pixels to be added to [orb_cur_top].
int orb_velocity_y_update(void);

// Updates [orb_cur_left] depending on the passed [velocity_x], *as well as*
// the global [orb_velocity_x] (!) to bounce the orb off the left or right
// edge of the playfield, if necessary.
void orb_move_x(orb_velocity_x_t velocity_x);
/// -------
