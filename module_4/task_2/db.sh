#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
echo $SCRIPT_DIR
ROOT_DIR=${SCRIPT_DIR%/*}
USERS_DB=$ROOT_DIR/task_2/users.db
BACKUP_DIR=$ROOT_DIR/task_2/backups

source $SCRIPT_DIR/db-commands.sh
source $SCRIPT_DIR/db-helpers.sh

commandErrorMessage="Invalid command: $*. Use '$0 help' for assistance."
command=$1
optionalParam=$2

checkCommand $*

case "$command" in
  add)
    runCommand addEntry
    ;;
  backup)
    runCommand createBackup
    ;;
  restore)
    runCommand restoreFromBackup
    ;;
  find)
    runCommand findByUsername
    ;;
  list)
    runCommand listAllEntries $optionalParam
    ;;
  '' | help)
    helpFunction
    ;;
  *)
    echo $commandErrorMessage
    ;;
esac