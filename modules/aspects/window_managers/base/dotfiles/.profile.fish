#!/usr/bin/env fish

# Autostart Hyprland on login
set current_tty $(tty)
set is_display $(set -q $DISPLAY)

if [ -n $DISPLAY ] && [ $current_tty = /dev/tty1 ];
  export XDG_CURRENT_DESKTOP=niri
  systemctl start niri.service
  #niri --session
end

if [ -n $DISPLAY ] && [ $current_tty = /dev/tty2 ];
  export XDG_CURRENT_DESKTOP=GNOME
  dbus-run-session -- gnome-shell --display-server --wayland
  # systemct start gnome.service
end

