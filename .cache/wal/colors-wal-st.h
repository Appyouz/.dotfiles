const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0F1D21", /* black   */
  [1] = "#6B5F5F", /* red     */
  [2] = "#8C7066", /* green   */
  [3] = "#91847B", /* yellow  */
  [4] = "#B8ABA9", /* blue    */
  [5] = "#C8B7B6", /* magenta */
  [6] = "#D8CCC8", /* cyan    */
  [7] = "#e9e3de", /* white   */

  /* 8 bright colors */
  [8]  = "#a39e9b",  /* black   */
  [9]  = "#6B5F5F",  /* red     */
  [10] = "#8C7066", /* green   */
  [11] = "#91847B", /* yellow  */
  [12] = "#B8ABA9", /* blue    */
  [13] = "#C8B7B6", /* magenta */
  [14] = "#D8CCC8", /* cyan    */
  [15] = "#e9e3de", /* white   */

  /* special colors */
  [256] = "#0F1D21", /* background */
  [257] = "#e9e3de", /* foreground */
  [258] = "#e9e3de",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
