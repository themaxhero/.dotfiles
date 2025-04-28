#!/usr/bin/env sh

notifications="$(gh api notifications --paginate -q '. | length' 2> /dev/null)"
[ -z notifications ] && echo "" || echo "$notifications" | awk '{ sum += $1 } END { print sum }'
