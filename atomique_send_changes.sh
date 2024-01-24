#!/usr/bin/env bash   

folder=~/atomique/data
echo "Sending all changes on ssh servers"

cd $folder

git add .
git commit -a -m "Edited servers"
git push

echo "Done!"
