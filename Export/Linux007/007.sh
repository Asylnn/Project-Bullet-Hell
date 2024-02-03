#!/bin/sh
echo -ne '\033c\033]0;PBH\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/007.x86_64" "$@"
