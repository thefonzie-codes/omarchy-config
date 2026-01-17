#!/bin/bash

chmod -R +x .
./paru.sh
./nvim.sh

for file in ./pkgs/*.sh; do
    if [ -f "$file" ] && [ -x "$file" ]; then
        "./$file"
    fi
done

