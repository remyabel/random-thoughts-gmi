#!/bin/bash

rm -rf random-thoughts-gmi
git clone --depth=1 https://tildegit.org/remyabel/random-thoughts-gmi
rm public_gemini/*.gmi
cp -a random-thoughts-gmi/*.gmi public_gemini/
cd public_gemini || exit
for file in *.gmi; do
  if [[ $file =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}.* ]]; then
    date=$(echo "$file" | grep -Eo '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
    touch -d "$date 00:00:00" "$file"
  fi
done
"$HOME"/.local/bin/gemfeed -a remyabel -b gemini://tilde.team/~remyabel/ -d "$HOME"/public_gemini -e remyabel@tilde.team
