#!/usr/bin/env bash

# while true
# do
#     METADATA=$(playerctl --player=spotify metadata --format "{{artist}}:{{title}}")
#     TITLE=$(echo $METADATA | cut -d ":" -f 1)
#     ARTIST=$(echo $METADATA | cut -d ":" -f 2)
#     if [ "$TITLE" = "Advertisement" ]
#     then
#         pkill spotify
#         spotify 2&>1 /dev/null &
#         sleep 5
#         playerctl -p spotify play-pause
#     else
#         echo "$ARTIST - $TITLE"
#     fi
# done

dbus-monitor --profile "interface=org.freedesktop.DBus.Properties,member=PropertiesChanged" | while read -r line; do
    CURRENT="$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | sed -n '/title/{n;p;}' | cut -d'"' -f2)"
    if [ "$CURRENT" == "Advertisement" ] || [ "$CURRENT" == "Spotify" ]; then
        pkill spotify
        spotify 2&>1 /dev/null &
        sleep 4
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    else
        echo "$CURRENT"
    fi
done
