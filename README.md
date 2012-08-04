# Purpose

Mute the volume of the computer for a limited period of time. For
example, to mute a commercial on an internet radio station.

# Description

When run, the application mutes the volume and puts a timer in the
system status bar. When the timer reaches zero, the computer is unmuted.
If the computer is unmuted while the timer is running, the timer stops
automatically.

Works on OSX 10.7 x86\_64.

# Notes

The timer is currently hard coded to 28 seconds and is not configurable
(without recompiling). The reason for 28 seconds, as oppposed to 30
seconds, is that it takes some small amount of time to recognize a
commercial and hit the mute button. This also prevents overrunning the
start of the next song.

# Screenshots

![Screenshot](MuteTimer/raw/master/screenshot.png)

# License

[WTFPL v2.0](http://sam.zoy.org/wtfpl)

Basically, do whatever you want to do. No restrictions.

