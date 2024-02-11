
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

tmux rename-window "atomique-about"

SLEEPSPEED=0.03

function teletype {
    CLEANTXT=$1
    for (( i=0; i<=${#CLEANTXT}; i++ )); do
        if [ -n "$SLEEPSPEED" ]; then
            read -t $SLEEPSPEED -n 1 && SLEEPSPEED=
        fi
           echo -n "${CLEANTXT:$i:1}"
    done
}

cat "$ATOMIQUE_ROOT_DIR/texts/atomique_about_header.txt" | echo -e "\e[93m$(cat)\e[0m"

file="$ATOMIQUE_ROOT_DIR/texts/atomique_about_text.txt"
body=$(<"$file")
teletype "$body"

read -n 1


