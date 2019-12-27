#!/bin/bash

DIR="tiddlers"

#TODO fail if not on master branch

count=0
change=$(git status -s $DIR)

while [ -n "$change" ] ; do
  echo # newline
  echo "-- Found change, waiting 10min"
  sleep 600 # if nothing changed for 10min

  newchange=$(git status -s $DIR)

  if [ "$change" = "$newchange" -o $count -ge 5 ] ; then
    git add $DIR
    git commit -m "BACKUP: $(date --rfc-3339=seconds)"
    git push || echo "-- ERROR - CANNOT PUSH"
    change=''
  else
    change=$newchange
  fi
  ((count += 1))
done
