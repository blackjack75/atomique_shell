#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

platform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
	   platform='linux'
sudo apt install most fzf ripgrep bat gping

   elif [ "$unamestr" = 'FreeBSD' ]; then
	      platform='freebsd'
sudo pkg install most fzf ripgrep bat gpingt
   else
    echo "Unsupported platform: $unamestr. Aborting script."
    exit 1
fi

