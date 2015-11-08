#!/usr/bin/env bash

# WD=$HOME/timelapse
WD=$HOME/temp/timelapse

# Fetch new images from RPi
rsync --remove-source-files -av pi@192.168.1.20:~/webcam/photos/ $WD/days/

# For earch day dir
for d in $WD/days/*/ ; do
    cd $d
    echo "`ls -1 | wc -l` files at $d"
    echo "Moving source files to 1-original"
    mkdir 1-original
    mv *.jpg 1-original/
    cd 1-original
    ffmpeg -r 12 -pattern_type glob -i "*.jpg" -c:v libx264 -r 12 ../timelapse.mp4
done
