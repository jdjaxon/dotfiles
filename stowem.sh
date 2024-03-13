#!/usr/bin/env bash

# Navigate to the script's directory or exit if it fails.
cd "$(dirname "$0")" || exit 1

# Iterate over all directories in the current location.
shopt -s nullglob
for app in */; do
    echo "Stowing ${app%/}..."
    if ! stow "${app%/}"; then
        echo "Error stowing ${app%/}"
        exit 1
    fi
done
