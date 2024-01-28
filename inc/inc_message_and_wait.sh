#!/usr/bin/env bash
              
wait_for_keypress() {
    if [ -n "$BASH_VERSION" ]; then
        read -n 1 -s key
    elif [ -n "$ZSH_VERSION" ]; then
        read -k1 key
    fi
}

echo "$message"
wait_for_keypress

