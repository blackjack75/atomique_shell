
# Prefer https://getclipboard.app if installed
if command -v clipboard &> /dev/null; then
	
	echo "Copied contents to Clipboard Project (command: clipboard)"
	cmd='clipboard'

elif command -v clipboard &> /dev/null; then
	
	echo "Copied contents to Clipboard Project (command: cb)"
	cmd='clipboard'

elif [ "$(uname)" == "Darwin" ]; then
    
	echo "Copied contents to Mac clipboard"
        cmd='pbcopy'

elif [ -n "$DISPLAY" ]; then
    
	echo "Copied contents to X11 clipboard"
        cmdX11='xclip -selection clipboard'

elif [[ "$LC_TERMINAL" = "ShellFish" ]]; then    
	
	echo "Copied contents to ShellFish clipboard"
        cmd='pbcopy'
        source ~/.shellfishrc
else
	echo "Unknown clipboard!"
	cmd='echo IDontKnowHowToCopyHere'

fi

echo "$COPYME" | $cmd
