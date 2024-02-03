#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

platform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
	   platform='linux'
sudo apt install most pandoc tidy fzf ripgrep bat pipx ping

   elif [ "$unamestr" = 'FreeBSD' ]; then
	      platform='freebsd'
sudo pkg install most pandoc tidy fzf ripgrep bat pipx gping

   elif [ "$unamestr" = 'Haiku' ]; then
	      platform='haiku'
pkgman install pandoc most pandoc tidy fzy ripgrep bat gping

   else	

    echo "Unsupported platform: $unamestr. Aborting script."
    exit 1
fi

#Haiku does not have pipx so install globally I guess
if command -v pipx &> /dev/null; then
pipcmd=pipx
    else
pipcmd=pip
fi

$pipcmd install toot
$pipcmd install beautifulsoup4

echo
echo "---------"
echo "mdcat requires building with cargo doesn't work on Haiku yet"
echo "press enter to try"
read UserInput

cargo install mdcat
