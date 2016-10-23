#!/usr/bin/env bash
here=$(dirname "$0")
/usr/local/bin/fswatch -o $0 | /usr/bin/xargs -n1 -I{} "$here/reload.sh"
