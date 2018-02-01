#!/bin/sh
# Workspace setup for when moving between locations

INT=eDP1
EXT=DP2

setup_office() {
    xrandr \
        --output $INT --mode 3840x2160 --scale 0.7x0.7 \
        --output $EXT --mode 3840x2160 --right-of $INT --primary
    xbacklight -set 100 -time 600
    new_bg
}

setup_home() {
    xrandr \
        --output $INT --mode 3840x2160 --scale 0.7x0.7 \
        --output $EXT --mode 3840x2160 --above $INT --primary
    xbacklight -set 80 -time 600
    new_bg
}

setup_mobile() {
    xrandr --output $INT --off
    xrandr \
        --output $INT --mode 3840x2160 --scale 1x1 \
        --output $EXT --off
    xbacklight -set 60 -time 600
    new_bg
}

rand_colour() {
    echo "#$(openssl rand -hex 3)"
}

new_bg() {
    local grad=$(rand_colour)-$(rand_colour)
    convert \
        -size 3840x2160 \
        -define gradient:direction=NorthEast gradient:$grad \
        bg.png
    feh --bg-scale ./bg.png
}

set -eo pipefail

case "$1" in
    office)     setup_office;;
    home)       setup_home;;
    mobile)     setup_mobile;;
    new-bg)     new_bg;;
    "")         echo "Usage: ./workspace <office|mobile|home>" && exit 1;;
    *)          echo "No workspace setup defined for $1" && exit 1;;
esac
