#!/bin/bash -ex
# Cron script for taking pics named by date
# Controllable by environment variables
# CAM_RESET_FOCUS set camera to infinite focus before taking picture
# CAM_ROTATION=0-360 rotate picture by degrees, default to 0
# CAM_MODEL=[c920e | hd3000 | simple] camera specific capture script

# Notes
# In CRON, only HOME, LOGNAME and SHELL env variables are set.

# Use ~/webcam as workdir. Create folder if it's not there.
WD=$HOME/webcam
mkdir -p $WD


# Reset camera focus to infinite
if ! [ -z "$CAM_RESET_FOCUS" ]; then
    v4l2-ctl -d 0 -c focus_auto=0
    v4l2-ctl -d 0 -c focus_absolute=0
    sleep 2
fi

# Set rotation by env var, default to 0.
ROTATION=${CAM_ROTATION:-0}

# Take photo with webcamera
case $CAM_MODEL in
    c920e)
        fswebcam -S 150 --frames 4 -r 1920x1080 --jpeg 90 --no-banner  --rotate $ROTATION --save $WD/img.jpg
        ;;
    hd3000)
        fswebcam -S 150 --frames 4 -r 1280x720 --jpeg 90 --no-banner --rotate $ROTATION --save $WD/img.jpg
        ;;
    simple)
        fswebcam -S 200 -r 640x480 --no-banner --jpeg 60 --no-banner --save $ROTATION $WD/img.jpg
        ;;
    *)
        echo "Please set CAM_MODEL env var."
        exit 1
        ;;
esac

# Put taken photo into timestamped folder with timestamp filename
dirname_timestamp=$(date +"%Y%m%d")
dirname=$WD/photos/$dirname_timestamp

filename_timestamp=$(date +"%Y%m%d-%H%M%S")
filename=$filename_timestamp.jpg

mkdir -p $dirname

# Move file to archive folder
mv $WD/img.jpg $dirname/$filename

exit 0
