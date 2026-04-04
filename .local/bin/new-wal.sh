#!/bin/sh

echo "Choosing wallpaper..."
wall=$(find $HOME/pictures/wallpapers -type f | shuf -n 1)
echo "Setting up wallpaper"
xwallpaper --zoom "$wall"

# --- GENERATE PYWAL COLORS ---
echo "Generating color scheme with pywal..."
# Use -o to generate all templates including alacritty
wal -i "$wall" -o >/dev/null 2>&1

# --- CLEANUP FOR DWM ---
sed -i 'N;$!P;D' $HOME/.cache/wal/colors-wal-dwm.h

# --- RECOMPILE SUCKLESS SOFTWARE ---
echo "Recompiling suckless software..."
sudo sh -c "
  cd $HOME/.local/src/suckless/dwm && make clean install
  cd $HOME/.local/src/suckless/dmenu && make clean install  
  cd $HOME/.local/src/suckless/slstatus && make clean install
"

# --- RELOAD ALACRITTY ---
echo "Reloading Alacritty colors..."
# Check if alacritty colors file was created
if [ -f "$HOME/.cache/wal/colors-alacritty.toml" ] || [ -f "$HOME/.cache/wal/colors-alacritty.yml" ]; then
    pkill -USR1 alacritty
    echo "Alacritty colors reloaded"
else
    echo "Warning: Alacritty colors file not found"
    echo "Available color files:"
    ls ~/.cache/wal/colors* | head -10
fi

echo "Done! Restart dwm for the new look"
