#!/bin/sh

branch=`git symbolic-ref HEAD --short`
if [ ${branch} = master ]; then
  cat <<\EOF
  Error: commit to master branch not allowed.
EOF
    exit 1
fi
