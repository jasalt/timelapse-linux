#!/bin/bash -eu
# Cron script for taking pics named by date

# Notes
# In CRON, only HOME, LOGNAME and SHELL env variables are set.

# Use ~/webcam as workdir. Create folder if it's not there.
WD=$HOME/webcam
mkdir -p $WD

# Take photo with webcamera

## Old crappy camera
# fswebcam -S 200 -r 640x480 --subtitle "Image glitches a bit. waiting for new camera..."  --jpeg 60 --save $WD/img.jpg

## Lifecam HD 3000
fswebcam -S 100 -r 1280x720 --jpeg 90 --no-banner --save $WD/img.jpg

## C920e
# Static focus far away
#v4l2-ctl -d 0 -c focus_auto=0
#v4l2-ctl -d 0 -c focus_absolute=0
#fswebcam -S 150 --frames 4 -r 1920x1080 --jpeg 90 --no-banner --save $WD/img.jpg
#fswebcam -S 150 --frames 4 -r 1280x720 --jpeg 90 --no-banner --save $WD/img.jpg


# Put taken photo into timestamped folder with timestamp filename
dirname_timestamp=$(date +"%Y%m%d")
dirname=$WD/photos/$dirname_timestamp

filename_timestamp=$(date +"%Y%m%d-%H%M%S")
filename=$filename_timestamp.jpg

mkdir -p $dirname

# Move file to archive folder
mv $WD/img.jpg $dirname/$filename
