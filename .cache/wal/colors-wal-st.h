const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#030202", /* black   */
  [1] = "#D70E1E", /* red     */
  [2] = "#F6112A", /* green   */
  [3] = "#B85B53", /* yellow  */
  [4] = "#8D7A8B", /* blue    */
  [5] = "#A396A4", /* magenta */
  [6] = "#CBAFB4", /* cyan    */
  [7] = "#e6e2e3", /* white   */

  /* 8 bright colors */
  [8]  = "#a19e9e",  /* black   */
  [9]  = "#D70E1E",  /* red     */
  [10] = "#F6112A", /* green   */
  [11] = "#B85B53", /* yellow  */
  [12] = "#8D7A8B", /* blue    */
  [13] = "#A396A4", /* magenta */
  [14] = "#CBAFB4", /* cyan    */
  [15] = "#e6e2e3", /* white   */

  /* special colors */
  [256] = "#030202", /* background */
  [257] = "#e6e2e3", /* foreground */
  [258] = "#e6e2e3",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
