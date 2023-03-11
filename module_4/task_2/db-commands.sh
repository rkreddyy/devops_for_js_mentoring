#!/bin/bash

source $SCRIPT_DIR/db-helpers.sh

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
ENDCOLOR=$'\e[0m'

addEntry() {
  read -p "Enter user name: " userName
  validateInput $userName
  read -p "Enter user role: " userRole
  validateInput $userRole

  local userEntry="$userName, $userRole"

  echo $userEntry >> $USERS_DB
  echo -e "${GREEN}Entry '$userEntry' was added${ENDCOLOR}"
}

createBackup() {
  local backupFile=`date +"%m-%d-%Y"`-users.db.backup

  if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
  fi

  cp $USERS_DB $BACKUP_DIR/$backupFile
  echo -e "${GREEN}Backup was created in 'data/backups/$backupFile' ${ENDCOLOR}"
}

restoreFromBackup() {
  local backupFiles=$(find $BACKUP_DIR -type f -name "*.backup" 2> /dev/null)

  if [ ! -d "$BACKUP_DIR" ] || [ -z "$backupFiles" ]; then
    echo -e "${RED}No backup file found.${ENDCOLOR}"
    helpFunction
    exit 0
  fi

  local sortedBackups=$(echo "$backupFiles" | sed -e 's|^.*/\(.*\)$|\1\t\0|' | sort -r -n -t\- -k 3.1 -k 1.1 -k 2.1 | cut -f 2-)
  local latestBackup=$(echo "$sortedBackups" | head -1)

  cat $latestBackup > $USERS_DB
  echo -e "${GREEN}Database was restored from $latestBackup${ENDCOLOR}"
}

findByUsername() {
  read -p "Enter user name for search: " userName
  local searchResults=`grep -i $userName $USERS_DB`

  if [ -z "$searchResults" ]
    then
      echo -e "${RED}User not found${ENDCOLOR}"
    else
      echo -e "${GREEN}$searchResults${ENDCOLOR}"
  fi
}

listAllEntries() {
  local inverseParam=$1
  local fileContent=`awk '{ print NR". " $0 }' < $USERS_DB`

  if [ -z "$inverseParam" ]
    then
      echo "$fileContent"
    else
      echo "$fileContent" | tac
  fi
}

helpFunction() {
   echo -e "${GREEN}'$0' is intended for process operations with users database and supports next commands:"
   echo -e "\tadd -> add new entity to database;"
   echo -e "\thelp -> provide list of all available commands;"
   echo -e "\tbackup -> create a copy of current database;"
   echo -e "\trestore -> replaces database with its last created backup;"
   echo -e "\tfind -> found all entries in database by username;"
   echo -e "\tlist -> prints content of database and accepts optional 'inverse' param to print results in opposite order.${ENDCOLOR}"
   exit 0
}