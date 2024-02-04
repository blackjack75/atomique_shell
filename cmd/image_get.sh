#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


clear
tmux rename-window "atomique-img2txt"

#allow passing URL also ok command line instead of including this
if [[ "$1" == *http* ]]; then
url=$1
fi

if [ -z "$url" ]
then
    echo "Using test url!"
o
      	url="https://lema.org/assets/blogimg/furniture_carrinho_roxinho_gato.jpg"
fi

cache_folder="/tmp/atomique_cache_images"
if [ ! -d "$cache_folder" ]; then
    mkdir -p "$cache_folder"
fi


# Calculate the MD5 hash of the URL
url_md5=$(echo -n "$url" | md5sum | awk '{print $1}')

cached_file="$cache_folder/$url_md5"
if [ ! -f "$cached_file" ]; then
    echo "Getting image: $url"

# Download the image
wget -O $cached_file $url  
else
	echo "Already cached at $cached_file"

fi

filesize=$(stat -c "%s" $cached_file)
echo "The size of the file is: $filesize bytes"

maxlines=$(tput cols)
# Get the width and height of the image
width=$(identify -format "%w" $cached_file)
height=$(identify -format "%h" $cached_file)
ratio=$(bc <<< "scale=2; $width / $height")
echo "Image width: $width"
echo "Image height: $height"
echo "Aspect ratio: $ratio"
image_format=$(identify -format "%m" $cached_file)
echo "Image format: $image_format"

# Limit width to terminal width if larger, otherwise limit height to 20 lines
if [ $width -gt "$(tput cols)" ]; then
    ww=$(tput cols)
    hh=$(bc <<< "scale=0; $(tput cols) / $ratio")
else
    ww=$width
    hh=$maxlines
fi

img2txt  -W $ww -H $hh -f ansi $cached_file          
read -n 1

