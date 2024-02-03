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
pkgman install pandoc most pandoc tidy fzy ripgrep bat pipx gping
   else	
    echo "Unsupported platform: $unamestr. Aborting script."
    exit 1
fi

pipx install toot
pipx install beautifulsoup4

cargo install mdcat
