#!/bin/bash -ex
# Cron script for taking pics named by date
# Controllable by environment variables
# CAM_RESET_FOCUS set camera to infinite focus before taking picture
# CAM_ROTATION=0-360 rotate picture by degrees, default to 0
# CAM_MODEL=[c920e | hd3000 | simple] camera specific capture script

# Notes
# In CRON, only HOME, LOGNAME and SHELL env variables are set.

`dirname $0`/its_not_dark.py
if [ $? -eq 1 ]; then echo "Not taking picture when it's dark." && exit 1; fi



# Reset camera focus to infinite
if ! [ -z "$CAM_RESET_FOCUS" ]; then
    v4l2-ctl -d 0 -c focus_auto=0
    v4l2-ctl -d 0 -c focus_absolute=0
    sleep 2
fi

# Set rotation by env var, default to 0.
ROTATION=${CAM_ROTATION:-0}

# Use ~/webcam as workdir. Create folder if it's not there.
WD=$HOME/webcam
mkdir -p $WD

TEMP_IMG=$WD/img.jpg

# Take photo with webcamera
case $CAM_MODEL in
    c920e)
        fswebcam -S 150 --frames 4 -r 1920x1080 --jpeg 90 --no-banner  --rotate $ROTATION --save $TEMP_IMG
        ;;
    hd3000)
        fswebcam -S 150 --frames 4 -r 1280x720 --jpeg 90 --no-banner --rotate $ROTATION --save $TEMP_IMG
        ;;
    simple)
        fswebcam -S 200 -r 640x480 --no-banner --jpeg 60 --no-banner --save $ROTATION $TEMP_IMG
        ;;
    *)
        echo "Please set CAM_MODEL env var."
        exit 1
        ;;
esac

if ! [ -e "$TEMP_IMG" ]; then
   echo "Image not taken possibly because of camera problems."
   exit 1
fi
   
# Put taken photo into timestamped folder with timestamp filename
dirname_timestamp=$(date +"%Y%m%d")
dirname=$WD/photos/$dirname_timestamp

filename_timestamp=$(date +"%Y%m%d-%H%M%S")
filename=$filename_timestamp.jpg

mkdir -p $dirname

# Move file to archive folder
mv $TEMP_IMG $dirname/$filename

exit 0
