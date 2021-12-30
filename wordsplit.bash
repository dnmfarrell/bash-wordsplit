#!/bin/bash
wordsplit () {
  WORDS=()
  WORDC=0
  WORDERR=
  OPTIND=1
  local quo= word= esc=
  while getopts ":" opt "-$1";do
    if [ -z $quo ];then
      if [ "$OPTARG" = '\' ];then
        if [ -z "$esc" ];then
          esc=1
          continue
        fi
      elif ([[ "$OPTARG" == [$' \t\n'] ]]&&[ -z "$esc" ]);then
        if [ -n "$word" ];then
          WORDS+=("$word")
          word=
          (( WORDC++ ))
        fi
        continue
      elif ([ "$OPTARG" = "'" ]||[ "$OPTARG" = '"' ])&&[ -z "$esc" ];then
        quo="$OPTARG"
        continue
      fi
    elif [ "$quo" = '"' ];then
      if [ -n "$esc" ];then
        ! [[ "$OPTARG" == [$'$\\`"\n'] ]] && word+='\'
      elif [ "$OPTARG" = '\' ];then
        esc=1
        continue
      elif [ "$OPTARG" = '"' ];then
        quo=
        continue
      fi
    elif [ "$OPTARG" = "$quo" ];then # single quote term
      quo=
      continue
    fi
    word+="$OPTARG"
    esc=
  done
  if [ -n "$quo" ];then
    WORDERR="found unterminated string"
    return 1
  elif [ -n "$word" ];then
    WORDS+=("$word")
    (( WORDC++ ))
  fi
  return 0
}
