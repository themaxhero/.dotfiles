#!/usr/bin/env bash

# this script was taken from
# https://gitlab.com/Oglo12/hyprland-rice/-/blob/main/eww/scripts/bar/get_workspaces?ref_type=heads

workspaces=$(hyprctl workspaces | grep "workspace ID" | cut -f3 -d " " | tr '\n' ':')
workspaces=${workspaces:0:$((${#workspaces} - 1))}
workspaces=$(echo "$workspaces" | sed 's/:/, /g')

echo "[$workspaces]"
