#!/bin/bash

checkCommand() {
  local command=$1
  local optionalParam=$2

  if [[ ! -z "$optionalParam" && ("$command" != "list" || "$optionalParam" != "inverse") ]]
    then
      echo $commandErrorMessage
      exit 1
  fi
}

handleFileAbsence() {
  read -p "Database file does not exist. Would you like to create it? (y/n): " -n 1

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi

  echo
  mkdir -p "$(dirname "$USERS_DB")" && touch "$USERS_DB"
}

runCommand() {
  local action="$1"
  local optional="$2"

  if [ $1 = restoreFromBackup ]; then
    echo $1
  elif [ ! -f $USERS_DB ]; then
    handleFileAbsence
  fi

  $action $optional
}

validateInput() {
  local input=$1

  if [[ ! "$input" =~ ^[a-zA-Z\ ]+$ ]]; then
    echo "Input must be latin letters!"
    exit 0
  fi
}
