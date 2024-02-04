#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

tmux rename-window "atomique-tootpix"
IMGDIR=~/atomique/data/img
mkdir -p $IMGDIR

echo "Checking auth to valid mastodon acount..."

if ! grep -q "ACTIVE" <<< $(toot auth); then
    echo "Error: Please use toot login before"
    toot login
fi


echo "Getting the 20 most recent bookmarks..."
#Use toot to extract URLs
#max width is important otherwise we get newline in URLs
urls=$(export COLUMNS=4096 && toot --no-color --max-width 4096 timeline -t '#caturday' -c 20 -1 | grep -E --color=never 'https?://[^\s<>"]+')

#I use a temp file because dor some reason it wouldnt work
#inside a variable
out="/tmp/atomique_img_urls.txt"
rm $out
touch $out

# Loop over lines in the variable
echo "$urls" | while IFS= read -r line; do
    # Split the line at each space
    read -ra words <<< "$line"
    # Iterate over the words
    for word in "${words[@]}"; do
        # Check if the word starts with http
        if [[ $word == http* ]]; then    
            # Append the URL to the new variable
	    #echo adding "$word"
            echo "$word"$'\n' >> $out
        fi
    done
done

urls=$(cat $out)


# Define the filename
filename="$IMGDIR/tootpix.txt"
temp_file="/tmp/tootpix_temp"

# Ensure the file exists or create it if it doesn't
touch "$filename"

# Count lines in the existing file
before=$(wc -l < "$filename")

# KEEP t URLs containing "media_attachments/files"
# #only jpeg
urls=$(echo "$urls" | grep "media_attachments/files")
urls=$(echo "$urls" | grep ".jp")

# Append new URLs to the temporary file, avoiding duplicates
echo "$urls" | awk '!seen[$0]++' > "$temp_file"
nburls=$(wc -l < "$temp_file")

# Concatenate the temporary file with the existing file
cat "$temp_file" "$filename" | awk '!seen[$0]++' > "$filename.temp" && mv "$filename.temp" "$filename"

rm "$temp_file"


after=$(wc -l < "$filename")
added=$((after - before))
echo "$nburls URLs extracted from bookmarks"
echo "Added $added new line(s) to $filename"

echo $SEPLINE
echo 10 latest URLS
echo $SEPLINE
head -n 10 $filename 


CACHEDIR=/tmp/atomique/cached_pix
mkdir -p $CACHEDIR

# Declare an array to store MD5 hashes
md5_hashes=()


# Loop through each URL in sources.txt
while IFS= read -r url; do
    md5_hash=$(echo -n "$url" | md5sum | awk '{print $1}')
    if [ -f "$CACHEDIR/$md5_hash.jpg" ]; then
        echo "Image already cached: $url"
    else
        curl -sS "$url" -o "$CACHEDIR/$md5_hash.jpg"
        echo "Downloaded: $url"
    fi
    md5_hashes+=("$md5_hash.jpg")
done < $filename

# Loop through each MD5 hash and display the corresponding image using timg
for hash in "${md5_hashes[@]}"; do
    timg "$CACHEDIR/$hash" 
done

echo Press any key
read -n 1
