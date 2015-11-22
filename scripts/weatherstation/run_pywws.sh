#!/bin/bash

# Deps: working installation of pywws
# http://jim-easterbrook.github.io/pywws/doc/en/html/guides/index.html

# Installation: make this runnable by `chmod +x FILENAME` and
#               copy path to rc.local like:
# /home/pi/pywws-weather-data/run-weather-logger.sh &

# Then run this or reboot computer.


# Creates screen
screen -dmS pywws bash

# And starts livelogger on it (note the newline in end of cmd)
screen -S pywws -X stuff "/usr/local/bin/pywws-livelog -vvv $HOME/pywws/
"
