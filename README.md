# spotify-polybar
A polybar module to display the current song and control Spotify playback (with experimental ad-skipping).

![preview](https://media.discordapp.net/attachments/785518379146281000/794366536625422346/unknown.png)

## Dependencies
- `dbus`
- `polybar`
- `spotify`

## Installation
#### Clone the repo into `~/.config/polybar`:
```
git clone https://github.com/v15hv4/spotify-polybar ~/.config/polybar/spotify
```
#### Include the .ini in your polybar config:
```
include-file = ~/.config/polybar/spotify/spotify.ini
```
#### Enable IPC in your polybar config:
```
enable-ipc = true
```
#### Add modules to bar:
```
modules-center: spotify spotify-previous spotify-control spotify-next
```

## Skipping Ads
The module can also attempt to automatically skip ads by relaunching Spotify in the background when an ad plays. 
However, this might be visually disruptive so it's recommended to bind the Spotify app to an unused workspace.  

To turn off skipping ads, flip to `ADSKIP=0` in `spotify.sh`.

#### Binding Spotify to a workspace in i3wm:
```
for_window [class="Spotify"] move to workspace n       # replace n with desired ws number
```

## Customization
Default glyphs (as used in the screenshot) are from the [waffle](https://github.com/adi1090x/polybar-themes/blob/master/fonts/waffle.bdf) bitmap font.  
They can be changed in `spotify.ini` as follows:
```
[module/spotify]
format-prefix = "<icon prefixing current song status>"
format-prefix-foreground = <prefix icon color hex>

[module/spotify-control]
hook-0 = echo "<pause icon>" 
hook-1 = echo "<play icon>"

[module/spotify-next]
exec = echo "<next song icon>"

[module/spotify-previous]
exec = echo "<previous song icon>"
```
