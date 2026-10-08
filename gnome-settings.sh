#!/usr/bin/env bash

# Keyboard Shortcuts
dconf reset -f /org/gnome/desktop/wm/keybindings/
dconf reset -f /org/gnome/mutter/keybindings/
dconf write /org/gnome/desktop/wm/keybindings/switch-applications "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-applications-backward "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Alt>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Alt>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Alt>9']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Alt>0']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-10 "['']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-last "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1 "['<Shift><Alt>7']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2 "['<Shift><Alt>8']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3 "['<Shift><Alt>9']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4 "['<Shift><Alt>0']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-10 "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-last "['']"

# Custom Keyboard Shortcuts
dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/binding "'<Super>Return'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/command "'ghostty'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/name "'Terminal'"
## https://gitlab.gnome.org/GNOME/nautilus/-/work_items/1687 Why not just implement something that maybe not everyone wants?
## https://ometer.com/preferences.html because surely that one opinion must be the only right one.
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/binding "'<Super>e'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/command "'nautilus --new-window'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/name "'Files'"

# Behaviour
dconf write /org/gnome/mutter/dynamic-workspaces "false"
dconf write /org/gnome/mutter/edge-tiling "true"
dconf write /org/gnome/mutter/attach-modal-dialogs "false"
dconf write /org/gnome/desktop/wm/preferences/num-workspaces "4"
dconf write /org/gnome/desktop/interface/enable-hot-corners "false"
dconf write /org/gnome/desktop/interface/gtk-enable-primary-paste "false"
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click "true"

# Appearance
dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/background/picture-options "'none'"
dconf write /org/gnome/desktop/background/primary-color "'#000000'"
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

dconf write /org/gnome/settings-daemon/plugins/color/night-light-enabled "true"
dconf write /org/gnome/settings-daemon/plugins/color/night-light-schedule-automatic "true"
dconf write /org/gnome/settings-daemon/plugins/color/night-light-temperature "1700"

# Power
dconf write /org/gnome/desktop/interface/show-battery-percentage "true"
dconf write /org/gnome/desktop/session/idle-delay "600"
dconf write /org/gnome/settings-daemon/plugins/power/power-saver-profile-on-low-battery "true"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout "900"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout "900"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type "'suspend'"

# Privacy
dconf write /org/gnome/desktop/privacy/remember-app-usage "false"
dconf write /org/gnome/desktop/privacy/remember-recent-files "false"
dconf write /org/gnome/desktop/notifications/show-in-lock-screen "false"

# Files (Nautilus)
dconf write /org/gtk/gtk4/settings/file-chooser/show-hidden "true"
dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first "true"
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"
dconf write /org/gnome/nautilus/preferences/show-image-thumbnails "'never'"
dconf write /org/gnome/nautilus/list-view/default-visible-columns "['name', 'size', 'date_modified'] "
dconf write /org/gnome/nautilus/list-view/default-column-order "['name', 'size', 'date_modified']"

# Extensions
dconf write /org/gnome/shell/enabled-extensions "['tiling-assistant@leleat-on-github', 'system-monitor@gnome-shell-extensions.gcampax.github.com']"
## System Monitor
dconf write /org/gnome/shell/extensions/system-monitor/show-cpu "true"
dconf write /org/gnome/shell/extensions/system-monitor/show-memory "true"
dconf write /org/gnome/shell/extensions/system-monitor/show-swap "true"
dconf write /org/gnome/shell/extensions/system-monitor/show-upload "false"
dconf write /org/gnome/shell/extensions/system-monitor/show-download "false"
