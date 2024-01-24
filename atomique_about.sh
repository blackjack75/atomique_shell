
SLEEPSPEED=0.03

function teletype {

CLEANTXT=$1
for (( i=0; i<=${#CLEANTXT}; i++ )); do
 sleep $SLEEPSPEED | echo -ne "${CLEANTXT:$i:1}"
 done

}

cat "$SCRIPT_DIR/atomique_about_header.txt"

file="$SCRIPT_DIR/atomique_about_text.txt"
body=$(<"$file")
teletype "$body"
