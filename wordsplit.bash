#!/bin/bash
wordsplit () {
  WORDS=()
  WORDC=0
  local idx=0 quo= word= c= esc=
  while :;do
    c="${1:$idx:1}"
    (( idx++ ))
    if [ -z $quo ];then
      if [ "$c" = '\' ];then
        if [ -z "$esc" ];then
          esc=1
          continue
        else
          esc=
        fi
      elif ([ "$c" = " " ]||[ "$c" = "	" ]&&[ -z "$esc" ])||[ -z "$c" ];then
        if [ -n "$word" ];then
          WORDS+=("$word")
          word=
          (( WORDC++ ))
        fi
        [ -z "$c" ] && break
        continue
      elif ([ "$c" = "'" ]||[ "$c" = '"' ])&&[ -z "$esc" ];then
        quo="$c"
        continue
      fi
    elif [ -z "$c" ];then
      echo "found unterminated string at col $idx: '$1'"
      exit 1
    elif [ "$c" = '\' ]&&[ "$quo" = '"' ];then
      if [[ "${1:$idx:1}" == [$\\\`\"] ]];then # 4 escapable chars
        c="${1:$idx:1}"
        (( idx++ ))
      fi
    elif [ "$c" = "$quo" ];then
      quo=
      continue
    fi
    esc=
    word+="$c"
  done
}
