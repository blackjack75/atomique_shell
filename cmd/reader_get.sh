#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


clear
tmux rename-window "atomique-reader"



if [ -z "$url" ]
then
    echo "Using test url!"

      	url="https://lema.org/blog/0006_procrastinators_no_due_dates"
fi

# Google cache not possible anymore !
#url="http://webcache.googleusercontent.com/search?q=cache:$url"

cache_folder="/tmp/atomique_cache"
if [ ! -d "$cache_folder" ]; then
    mkdir -p "$cache_folder"
fi


# Calculate the MD5 hash of the URL
url_md5=$(echo -n "$url" | md5sum | awk '{print $1}')

cached_file="$cache_folder/$url_md5.html"
clean_file="$cache_folder/$url_md5_clean.html"
if [ ! -f "$cached_file" ]; then
    echo "Getting page: $url"

    user_agent="atomique 1.0 (like Lynx 2)"
    html_content=$(curl -s -A "$user_agent" -L "$url")

    echo "$html_content" > "$cached_file"


else
    # Retrieve HTML content from cache
    echo "From cache: $url ($cached_file)"
    html_content=$(cat "$cached_file")
fi

echo "filtering..."

# List of tags to remove
tags=("script" "img" "style")

# Use tidy to convert HTML to XHTML and suppress messages
xhtml_text=$(tidy  --drop-empty-elements --drop-tags a,img,svg,style <<< "$html_content" )
for tag in "${tags[@]}"; do
    echo Removing $tag
#    xhtml_text=$(echo $xhtml_text | sed 's/<script[^>]*>.*<\/script>//g')
   # xhtml_text=$(echo $xhtml_text | sed 's/<$tag[^>]*>.*<\/$tag>//g')

done

#echo "$html_content" | most -wD
#echo "$xhtml_text" | most -wD

echo "Converting to markdown..."
markdown_content=$(echo "$xhtml_text" | pandoc -f html -t markdown_strict --wrap=none --resource-path=) 

    echo "$markdown_content" > "$cached_file.md"
    echo "Original size $(stat -c %s $cached_file) incache $cached_file"

    echo "Markdown size $(stat -c %s $cached_file.md)"

    echo "$markdown_content" | most -wD

    echo "DEBUG press enter"
    read userInput


