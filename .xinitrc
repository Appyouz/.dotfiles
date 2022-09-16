xrandr --output LVDS1 --mode 1366x768 &
xrandr --output LVDS1 --auto &
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &
wal -R &
exec slstatus &
exec startdwm 

