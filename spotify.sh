#!/usr/bin/env bash

# read dbus-monitor 
dbus-monitor --profile "interface=org.freedesktop.DBus.Properties,member=PropertiesChanged" | while read -r line; do

    # parse metadata
    METADATA=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata') 
    ARTIST=$(echo "$METADATA" | grep -A2 "xesam:artist" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')
    TITLE=$(echo "$METADATA" | grep -A1 "xesam:title" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')

    # sneaky adblock
    if [ "$TITLE" == "Advertisement" ] || [ "$TITLE" == "Spotify" ]; then
        pkill spotify
        spotify 2&>1 /dev/null &
        sleep 4
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

    # polybar output
    else
        echo "$ARTIST - $TITLE"
    fi

done
