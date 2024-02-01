
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

SLEEPSPEED=0.03

function teletype {

CLEANTXT=$1
for (( i=0; i<=${#CLEANTXT}; i++ )); do
 sleep $SLEEPSPEED | echo -ne "${CLEANTXT:$i:1}"
 done

}

cat "$SCRIPT_DIR/texts/atomique_about_header.txt"

file="$SCRIPT_DIR/texts/atomique_about_text.txt"
body=$(<"$file")
teletype "$body"
