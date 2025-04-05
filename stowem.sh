#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "[Dry Run Mode Enabled]"
fi

shopt -s nullglob
for app in */; do
    app_name="${app%/}"
    echo "Stowing ${app_name}..."

    if $DRY_RUN; then
        stow --no --verbose=2 "${app_name}"
        echo
    else
        if ! stow "${app_name}"; then
            echo "Error stowing ${app_name}"
            exit 1
        fi
    fi
done
