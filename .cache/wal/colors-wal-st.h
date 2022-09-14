const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a0a0b", /* black   */
  [1] = "#695655", /* red     */
  [2] = "#872D29", /* green   */
  [3] = "#8B7172", /* yellow  */
  [4] = "#937F81", /* blue    */
  [5] = "#99888A", /* magenta */
  [6] = "#A89496", /* cyan    */
  [7] = "#d1cacb", /* white   */

  /* 8 bright colors */
  [8]  = "#928d8e",  /* black   */
  [9]  = "#695655",  /* red     */
  [10] = "#872D29", /* green   */
  [11] = "#8B7172", /* yellow  */
  [12] = "#937F81", /* blue    */
  [13] = "#99888A", /* magenta */
  [14] = "#A89496", /* cyan    */
  [15] = "#d1cacb", /* white   */

  /* special colors */
  [256] = "#0a0a0b", /* background */
  [257] = "#d1cacb", /* foreground */
  [258] = "#d1cacb",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
