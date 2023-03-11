Create an empty directory named data with a file named users.db in the project’s module_4/task_2 directory.
Create a directory named scripts in the project’s module_4/task_2 directory. Using Vim editor in your terminal create a shell script named db.sh in the scripts directory. This script must support the following commands:
Adds a new line to the users.db. The script must prompt a user to type the username of a new entity. After entering the username, the user must be prompted to type a role.

$ db.sh add
Validation rules:

username – Latin letters only
role – Latin letters only

New entity of users.db should be a comma-separated value like: _username_, _role_.

The script must check the existence of the users.db file (for all commands accept $ db.sh or $ db.sh help ones) and prompt to confirm to create one if it does not exist and to continue initial operation after creation is completed.

$ db.sh
or

$ db.sh help
Prints instructions on how to use this script with a description of all available commands (add, backup, find, list, help)

$ db.sh backup
Creates a new file, named %date%-users.db.backup which is a copy of current users.db

$ db.sh restore
Takes the last created backup file and replaces users.db with it. If there are no backups - script should print: “No backup file found”

$ db.sh find 					
Prompts the user to type a username, then prints username and role if such exists in users.db. If there is no user with the selected username, the script must print: “User not found”. If there is more than one user with such a username, print all found entries.

$ db.sh list
Prints the content of the users.db in the format:

N. username, role 	
where N – a line number of an actual record

Accepts an additional optional parameter --inverse which allows results in the opposite order – from bottom to top. Running the command $ db.sh list --inverse will return the result as follows:

$ db.sh list --inverse

  10. John, admin
  9. Valerie, user
  8. Ghost, guest
   …
NB: here you can find some samples that you might find handy while solving the task.