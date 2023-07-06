setxkbmap -option compose:caps
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient CircularScrolling=1
synclient CircScrollTrigger=1
synclient PalmDetect=1
xscreensaver -nosplash &
xset b off
xrandr --output DP-1-3-1 --primary --auto --right-of DP-1-3-2 --output DP-1-3-2 --auto --output eDP-1-1 --off
exec ck-launch-session awesome
