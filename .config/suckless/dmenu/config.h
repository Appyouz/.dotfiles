/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 700;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Hack Nerd Font:size=15:style:medium"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
/* static const char *prompt      = "apps";      /1* -p  option; prompt to the left of input field *1/ */
//static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	//[SchemeNorm] = { "#bbbbbb", "#222222" },
	//[SchemeSel] = { "#eeeeee", "#005577" },
	//[SchemeOut] = { "#000000", "#00ffff" },
//};
#include "/home/mac/.cache/wal/colors-wal-dmenu.h"
/* static const char *colors[SchemeLast][2] = { */
/* 	/1*     fg         bg       *1/ */
/* 	[SchemeNorm] = { "#f8f8f2", "#282a36" }, */
/* 	[SchemeSel] = { "#ff5555", "#282a36" }, */
/* 	[SchemeOut] = { "#000000", "#00ffff" }, */
/* }; */


/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 5;
static unsigned int columns    = 1;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 5;
