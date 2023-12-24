#!/usr/bin/env sh

# this script was taken from
# https://gitlab.com/Oglo12/hyprland-rice/-/blob/main/eww/scripts/bar/get_workspaces?ref_type=heads
get_workspaces() {
  i3-msg -t get_workspaces
}

get_workspaces;
while true; do
  i3-msg -t subscribe '["workspace"]' > /dev/null && get_workspaces;
done