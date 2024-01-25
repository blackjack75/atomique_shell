
# Prefer https://getclipboard.app if installed
# Somehow on Mac we get the 'cb' command but on Linux distributions
# it's usually only 'clipboard' and no shortcut
# I have an alias myself but it's not always there

if command -v cb &> /dev/null; then
	
	echo "Copied contents to Clipboard Project (command: cb)"
	cmd='cb copy'

# BeOS - Haiku have a system command named clipboard,
elif command -v clipboard &> /dev/null; then
	
	if [ "$(uname)" == "Haiku" ]; then
		echo "Copied contents to Haiku clipboard"
        	cmd='clipboard -i'
        else

		echo "Copied contents to Clipboard Project (command: clipboard)"
		cmd='clipboard copy'

elif [ "$(uname)" == "Darwin" ]; then
    
	echo "Copied contents to Mac clipboard"
        cmd='pbcopy'

elif [ -n "$DISPLAY" ]; then
    
	echo "Copied contents to X11 clipboard"
        cmd='xclip -selection clipboard'

elif [[ "$LC_TERMINAL" = "ShellFish" ]]; then    
	
	echo "Copied contents to ShellFish clipboard"
        cmd='pbcopy'
        source ~/.shellfishrc
else
	echo "Unknown clipboard!"
	cmd='echo IDontKnowHowToCopyHere'

fi

echo "$COPYME" | $cmd
