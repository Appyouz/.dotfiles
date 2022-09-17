static const char norm_fg[] = "#e9e3de";
static const char norm_bg[] = "#0F1D21";
static const char norm_border[] = "#a39e9b";

static const char sel_fg[] = "#e9e3de";
static const char sel_bg[] = "#8C7066";
static const char sel_border[] = "#e9e3de";

static const char urg_fg[] = "#e9e3de";
static const char urg_bg[] = "#6B5F5F";
static const char urg_border[] = "#6B5F5F";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};
