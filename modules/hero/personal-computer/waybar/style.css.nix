{ fontSize, ... }:
''
* {
	font-size: ${toString fontSize}px;
	font-family: scientifica, dina;
}

window#waybar {
	background: #303030;
	color: #fdf6e3;
}

#custom-right-arrow-dark,
#custom-left-arrow-dark {
	color: #1a1a1a;
}
#custom-right-arrow-light,
#custom-left-arrow-light {
	color: #292b2e;
	background: #101010;
}

#workspaces,
#clock.1,
#clock.2,
#clock.3,
#pulseaudio,
#custom-gpu-usage,
#custom-weather,
#custom-events,
#memory,
#cpu,
#battery,
#disk,
#tray {
	background: #101010;
}

#workspaces button {
	padding: 0 2px;
	color: #fdf6e3;
}
#workspaces button.focused {
	color: #268bd2;
}
#workspaces button:hover {
	box-shadow: inherit;
	text-shadow: inherit;
}
#workspaces button:hover {
	background: #101010;
	border: #1a1a1a;
	padding: 0 4px;
}

#pulseaudio {
	color: #268bd2;
}

#custom-gpu-usage {
	color: #00ff00;
}

#memory {
	color: #2aa198;
}
#cpu {
	color: #6c71c4;
}
#battery {
	color: #859900;
}
#disk {
	color: #b58900;
}

#clock,
#pulseaudio,
#memory,
#cpu,
#battery,
#disk {
	padding: 4px 16px;
}
''