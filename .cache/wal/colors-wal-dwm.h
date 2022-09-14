static const char norm_fg[] = "#93c5d2";
static const char norm_bg[] = "#0c060f";
static const char norm_border[] = "#668993";

static const char sel_fg[] = "#93c5d2";
static const char sel_bg[] = "#1C5665";
static const char sel_border[] = "#93c5d2";

static const char urg_fg[] = "#93c5d2";
static const char urg_bg[] = "#084756";
static const char urg_border[] = "#084756";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
