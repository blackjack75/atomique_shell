
# We cannot use full with because of fzf preview
nbcols=$(tput cols)
nbcols=$((nbcols - 4))
export TOPLINE=$(printf %"$nbcols"s |tr " " "*")
export SEPLINE=$(printf %"$nbcols"s |tr " " "-")

