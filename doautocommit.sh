#!/bin/bash

eval `keychain --eval github`

while : ; do
  echo -ne '.'
  ./autocommit.sh
  sleep 3600
done
