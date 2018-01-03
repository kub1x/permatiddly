#!/bin/bash

DIR="tiddlers"

while : ; do
  #TODO fail if not on master branch

  change=$(git status -s $DIR)

  while [ -n "$change" ] ; do
    echo "-- Found change, waiting 10min"
    sleep 600 # if nothing changed for 10min

    newchange=$(git status -s $DIR)

    if [ "$change" = "$newchange" ] ; then
      git add $DIR
      git commit -m "BACKUP: $(date --rfc-3339=seconds)"
      git push || echo "-- ERROR - CANNOT PUSH"
      change=''
    else
      change=$newchange
    fi
  done

  echo "-- Nothing, waiting 10min"
  sleep 600 # check every 1min
done
