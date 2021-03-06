#!/bin/bash

rm "$HOME"/public_gemini/*.gmi
cp -a *.gmi "$HOME"/public_gemini/
cd "$HOME"/public_gemini || exit
idx=0
for file in *.gmi; do
  if [[ $file =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}.* ]]; then
    date=$(echo "$file" | grep -Eo '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
    touch -d "$date 00:00:0$idx" "$file"
    idx=$(($idx+1))
  fi
done
"$HOME"/.local/bin/gemfeed -a remyabel -b gemini://tilde.team/~remyabel/ -d "$HOME"/public_gemini -e remyabel@tilde.team
