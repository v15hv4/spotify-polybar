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
    METADATA=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata') 
    ARTIST=$(echo "$METADATA" | grep -A2 "xesam:artist" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')
    TITLE=$(echo "$METADATA" | grep -A1 "xesam:title" | tail -n 1 | sed 's/.*"\(.*\)".*/\1/g')

    if [ "$TITLE" == "Advertisement" ] || [ "$TITLE" == "Spotify" ]; then
        pkill spotify
        spotify 2&>1 /dev/null &
        sleep 4
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    else
        echo "$ARTIST - $TITLE"
    fi
done
