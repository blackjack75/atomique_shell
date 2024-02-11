
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-license"

LICENSE=$(<$ATOMIQUE_ROOT_DIR/LICENSE)

# Replace double newlines with a unique delimiter
license_with_delimiter=$(echo "$LICENSE" | sed ':a;N;$!ba;s/\n\n/\x1E/g')

# Remove single newlines
unwrapped_license=$(echo "$license_with_delimiter" | tr -d '\n')

# Replace the unique delimiter back with double newlines
unwrapped_license=$(echo "$unwrapped_license" | sed 's/\x1E/\n\n/g')


#wrap to display width
echo "$unwrapped_license" | fold -w $(tput cols) -s | most -wd

#most -wd $ATOMIQUE_ROOT_DIR/LICENSE$ATOMIQUE_ROOT_DIR/LICENSE
