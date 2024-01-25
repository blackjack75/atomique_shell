
cmdX11='xclip -selection clipboard'
cmdMac='pbcopy'
cmdSF='pbcopy'
#pbcopy also works in ShellFish on iOS

if [ "$(uname)" == "Darwin" ]; then
    
	echo "Copied contents to Mac clipboard"
	cmd=$cmdMac

elif [ -n "$DISPLAY" ]; then
    
	echo "Copied contents to X11 clipboard"
	cmd=$cmdX11

elif [[ "$LC_TERMINAL" = "ShellFish" ]]; then    
	
	echo "Copied contents to ShellFish clipboard"
        cmd=$cmdSF
        source ~/.shellfishrc
else
	echo "Unknown clipboard!"
	cmd='echo IDontKnowHowToCopyHere'

fi

echo "$COPYME" | $cmd
