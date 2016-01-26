# A simple script to play/pause Spotify when playing in a browser
# Note that for this to work in all cases, you should be using chrome-stable or
# some browser which *isn't* chrome-beta for your normal web browsing and
# chrome-beta for playing Spotify.

# Finds the chrome-beta window
chr=`xdotool search --class chrome-beta | tail -1`

# This chained command does the following:
#  1 - Gets the currently active window and puts in on the window stack
#  2 - Focuses the window we found using the first command
#  3 - Sends the following keystrokes to that window with a 10ms delay between
#    Ctrl+1 (Select the first tab)
#    Space (Play/Pause in Spotify)
#    Ctrl+9 (Select the last tab)
#  4 - Reactivate the first window on the window stack, aka the previously
#      active window.
xdotool getactivewindow windowfocus ${chr} key --window ${chr} --delay 10 \
        ctrl+1 space ctrl+9 windowactivate
