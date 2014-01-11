#!/usr/bin/env bash

# Deps:
#   Ubuntu/Debian : sudo apt-get install xdotool xsel
#   RH            : yum install xdotool xsel
#   OpenSuse      : zypper install xdotool xsel
#
#   For hotkey    : xkeybind
#                    "vim_omni"
#                       Mod2 + F12

xdotool -<<EOF
    sleep 0.1
    key ctrl+a
    key ctrl+c
EOF
xsel > /tmp/vimy
gvim --nofork '+$|set ff=unix|startinsert!' /tmp/vimy
cat /tmp/vimy | xsel -bi
xdotool - <<EOF
    key ctrl+a
    key ctrl+v
EOF
