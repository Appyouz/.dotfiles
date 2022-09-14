const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c060f", /* black   */
  [1] = "#084756", /* red     */
  [2] = "#1C5665", /* green   */
  [3] = "#545E68", /* yellow  */
  [4] = "#96686F", /* blue    */
  [5] = "#3F5A96", /* magenta */
  [6] = "#AC42BA", /* cyan    */
  [7] = "#93c5d2", /* white   */

  /* 8 bright colors */
  [8]  = "#668993",  /* black   */
  [9]  = "#084756",  /* red     */
  [10] = "#1C5665", /* green   */
  [11] = "#545E68", /* yellow  */
  [12] = "#96686F", /* blue    */
  [13] = "#3F5A96", /* magenta */
  [14] = "#AC42BA", /* cyan    */
  [15] = "#93c5d2", /* white   */

  /* special colors */
  [256] = "#0c060f", /* background */
  [257] = "#93c5d2", /* foreground */
  [258] = "#93c5d2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
