#!/usr/bin/env bash

for app in $(ls | grep -v *.sh)
do
    echo "Stowing $app..."
    stow "$app"
done
