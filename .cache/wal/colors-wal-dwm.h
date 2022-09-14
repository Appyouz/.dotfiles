static const char norm_fg[] = "#e6e2e3";
static const char norm_bg[] = "#030202";
static const char norm_border[] = "#a19e9e";

static const char sel_fg[] = "#e6e2e3";
static const char sel_bg[] = "#F6112A";
static const char sel_border[] = "#e6e2e3";

static const char urg_fg[] = "#e6e2e3";
static const char urg_bg[] = "#D70E1E";
static const char urg_border[] = "#D70E1E";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
