extern int portal_dst_left;
extern int portal_dst_top;
// Additional flag on top of [orb_in_portal]. Left as true for a few more
// frames after the orb has exited a portal, to prevent it from immediately
// re-entering.
extern bool16 portals_blocked;
