#!/bin/bash
source wordsplit.bash
while IFS= read -r;do
  wordsplit "$REPLY"
  printf "%s\n" "${WORDS[@]}"
done
