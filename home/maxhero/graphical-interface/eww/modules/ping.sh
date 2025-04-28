#!/usr/bin/env sh

HOST="8.8.8.8"
PING=$(ping -c 1 -4 $HOST 2> /dev/null)

if [[ $? -ne 0 ]]; then
  echo "No"
else
  echo "$(echo $PING | tail -n 1 | head -n 1 | sed -E 's/^.+=\s//g' | sed -E 's/.+\/(.+)\/.+\/.+ ms/\1/' | sed -E 's/\.(.+)$//') ms"
fi
