Images are arranged in daily directories under sequences folder.
Outputs videos are stored

in seImages are held in single  and named in forma

    sequences/yyyymmdd/yyyymmdd-hhmmss.jpg

# Cleanup content
## Cleanup dark images
Imagemagick `identify` command outputs information about image content. Currently the average standard deviation value is used for recognizing dark (or white) images.

    identify -verbose 20150711-140001.jpg | sed -e '/Image statistics:/,/standard deviation:/ !d' -e '/standard deviation/ !d' -e 's/\ *[\: a-z]*//' -e 's/(.*//'

When looking for black images, for better cameras a cutoff value of 4 might be ideal. For lower end cameras with more noise, cutoff value of 6-15 should work.

A simple command line tool `mvdullimg` helps batch processing out dark images by running script in parallel with `xargs`:

    ls | xargs -I {} -P 8 -n 1 -t  bash -c 'cd {} && mvdullimg -o ../../dull -d 4'

Try the tool with high value (eg. 20) and monitor script output to see what kind of values would work for your content.

## Remove bottom border
Some images have had a title outputted by `fswebcam` on the bottom by mistake. It's easily removed with `imagemagick`.

    convert $img -gravity South -chop  0x21 $img

# Add metadata
    exiftool ./*.jpg -overwrite_original -GPSLatitudeRef=N -GPSLatitude=61.892220 -GPSLongitudeRef=E -GPSLongitude=25.655319 -GPSImgDirectionRef=T -GPSImgDirection=290 -Model="Logitech c930e"

# Compose video

# Upload to youtube
