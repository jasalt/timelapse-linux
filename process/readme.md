Images are arranged in daily directories under sequences folder in following dir structure and named with timestamp.

    sequences/yyyymmdd/yyyymmdd-hhmmss.jpg

# Cleanup content
See also TODO section
## Cleanup dark images
Imagemagick `identify` command outputs information about image content. Currently the standard deviation value is used for recognizing dark (or white) images.

    identify -format "%[standard-deviation]" 20150711-140001.jpg

When looking for black images, for better cameras a cutoff value of 700 might be ideal. For lower end cameras with more noise, cutoff value of 800-900 could work.

A simple command line tool `mvdullimg` helps batch processing out dark images by running script in parallel with `xargs`:

    ls | xargs -I {} -P 8 -n 1 -t  bash -c 'cd {} && mvdullimg -o ../../dull -d 700'

Try the tool with high value (eg. 1000000) and monitor script output to see what kind of values would work for your content.

## Remove bottom border
Some images have had a title outputted by `fswebcam` on the bottom by mistake. It's easily removed with `imagemagick`. Just make sure that pixel values can be divided by 2, as ffmpeg libx264 may give errors otherwise.

    convert $img -gravity South -chop  0x22 $img

As a batch operation for range of directories run:

    for dir in 2015081{1..8}*; do
        echo $dir ; done |
        xargs -I {} -P 8 -t bash -c 'cd {} && for img in *.jpg; do convert $img -gravity South -chop  0x22 $img; done'

# Add geo metadata
Default filming location

exiftool ./*.jpg -overwrite_original -GPSLatitudeRef=N -GPSLatitude=61.892220 -GPSLongitudeRef=E -GPSLongitude=25.655319 -GPSImgDirectionRef=T -GPSImgDirection=290 -Model="Microsoft Lifecam HD-3000"

-Model="Logitech c930e"
-Model="Microsoft Lifecam HD-3000"

# Compose video
Create compressed video from image sequence.

    ffmpeg -r 24 -pattern_type glob -i "*.jpg" -c:v libx264 -r 24 output.mp4

Running for a batch of directories:

    for d in 201508{11..18}
    do
    ffmpeg -r 24 -pattern_type glob -i "$d/*.jpg" -c:v libx264 -r 24 ../outputs/$d.mp4
    done

For now all image sequences with different intervals are compiled into video with static framerate of 24. This gives noticeable speed difference in videos. See TODO.

# Upload to youtube
Using https://github.com/tokland/youtube-upload for automated uploads. Set authentication JSON file path (documented in the `youtube-dl` repo) as environment variable: `export YOUTUBE_CREDENTIALS=path_to_google_credentials_file.json`.

Upload videos by issuing command `youtube-up-wl 20151224.mp4`. Or upload multiple at a time `youtube-up-wl *.mp4`.

# TODO
- Cleanup red center of videos recorded with cheap webcam (apply color effect with circular mask to videos, ffmpeg/imagemagick).
- Cleanup camera light reflection from early content (with Natron roto mask automation or simple circular mask opacity scaling against frame brightness values with ffmpeg/imagemagick. 
- Calculate and adjust framerates for sequences in different intervals.
- Setup motion interpolation for higher interval videos with [Butterflow](https://github.com/dthpham/butterflow)
