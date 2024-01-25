#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

selected_file=$piped_input


echo $SEPLINE
echo " $title" 
echo $SEPLINE

echo " File : $selected_file"

echo $SEPLINE

maxlines=10
cutme=$(head -n "$maxlines" -q "$selected_file")

nb=0
# Print each line of cutme on a separate line
echo "$cutme" | while IFS= read -r line; do
    echo "$line"
    ((nb++))
done


if [ "$nb" -ge "$maxlines" ]; then
	echo "(...)"
fi

echo $cutme
echo $SEPLINE





