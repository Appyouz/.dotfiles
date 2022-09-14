static const char norm_fg[] = "#d1cacb";
static const char norm_bg[] = "#0a0a0b";
static const char norm_border[] = "#928d8e";

static const char sel_fg[] = "#d1cacb";
static const char sel_bg[] = "#872D29";
static const char sel_border[] = "#d1cacb";

static const char urg_fg[] = "#d1cacb";
static const char urg_bg[] = "#695655";
static const char urg_border[] = "#695655";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};
