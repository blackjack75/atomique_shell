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

echo "Cleaning up..."

tidy_content=$($SCRIPT_DIR/py/fixhtml_droptags.py $cached_file )

#tidy_content=$(tidy --force-output yes --drop-empty-elements yes  <<< "$html_content" )


     echo "Converting to markdown..."
     markdown_content=$(echo "$tidy_content" | pandoc -f html -t markdown_strict+pipe_tables --wrap=none --resource-path=)

    #some span tags remain somehow after markdown conversion +
    markdown_content=$(sed 's/<span[^>]*>//g; s/<\/span>//g' <<< "$markdown_content")

    # Remove empty lines
    markdown_content=$(echo "$markdown_content" | tr -s '\n' | sed '/^$/ {N;N;d}')

    echo "$tidy_content" > "$cached_file.tidy"
    echo "$markdown_content" > "$cached_file.md"

    size_ori=$(stat -c %s $cached_file)
    size_tidy=$(stat -c %s $cached_file.tidy)
    size_md=$(stat -c %s $cached_file.md)
    echo "incache $cached_file"
    echo "incache $cached_file.tidy"
    echo "incache $cached_file.md"

    echo $SEPLINE
    echo "Original size : $size_ori"
    echo "Tidy size: $size_tidy"
    echo "Markdown size: $size_md"
    echo $SEPLINE
    reduced=$((100 * (size_ori - size_md) / size_ori))
    echo "Useless crap removed: $reduced %"
    echo $SEPLINE

    echo "DEBUG press enter"
    read userInput
    #echo "$markdown_content" | most -wD
    echo "$markdown_content" | mdcat -p 


