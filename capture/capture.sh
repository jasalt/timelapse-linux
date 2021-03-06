#!/bin/bash -ex
# Script for taking webcam pictures and archiving them named by date.
# Add exif geo metadata to frames.
# Discards dark images.

echo "Running capture.sh at `date`"

# Reset camera focus to infinite

v4l2-ctl -d 0 -c focus_auto=0
v4l2-ctl -d 0 -c focus_absolute=0
echo "Set focus to infinite."
sleep 1

# Set rotation by env var, default to 0.
ROTATION=${CAM_ROTATION:-0}

# Use ~/webcam as workdir. Create folder if it's not there.
WD=$HOME/webcam
mkdir -p $WD

filename_timestamp=$(date +"%Y%m%d-%H%M%S")
filename=$filename_timestamp.jpg

TEMP_IMG=$WD/$filename

# Take photo with webcamera

# Minimum deviation, image is too dark when going under this value.
MIN_DEV=700 # Logitech c930e

fswebcam -S 150 --frames 4 -r 1920x1080 --jpeg 85 --no-banner   --save $TEMP_IMG
# --rotate 180

## Other cameras
# MIN_DEV=850 # Microsoft Lifecam HD-3000
# Resolution 1280 x 720

if ! [ -e "$TEMP_IMG" ]; then
   echo "Image not taken possibly because of camera problems."
   exit 1
fi

# Scrap dark images
`dirname $0`/img_is_dark -d $MIN_DEV $TEMP_IMG
if [ $? -eq 1 ];
then
    echo "Image too dark, deleting."
    rm $TEMP_IMG
    exit 1
fi

# Add GPS EXIF metadata
exiftool $TEMP_IMG -overwrite_original -GPSLatitudeRef=N -GPSLatitude=61.892220 -GPSLongitudeRef=E -GPSLongitude=25.655319 -GPSImgDirectionRef=T -GPSImgDirection=290 -Model="Logitech C930e"

# Store taken photo into folder with datestamp with full timestamp filename
dirname_timestamp=$(date +"%Y%m%d")
dirname=$WD/photos/$dirname_timestamp

mkdir -p $dirname

# Move file to archive folder
mv $TEMP_IMG $dirname/$filename

exit 0
