#!/bin/bash

SERVER_HOST_DIR=/Users/Ravikiran_Anumula/Documents/devops_for_js_mentoring/lab_2/nestjs-rest-api
CLIENT_HOST_DIR=/Users/Ravikiran_Anumula/Documents/devops_for_js_mentoring/lab_2/shop-react-redux-cloudfront

# destination folder names can be changed
SERVER_REMOTE_DIR=/var/app/nestjs-rest-api
CLIENT_REMOTE_DIR=/var/www/shop-react-redux-cloudfront

# SSH connection alias name
SSH_ALIAS=sshuser@192.168.64.9

# SSH Username
SSH_USER=sshuser

check_remote_dir_exists() {
  echo "Check if remote directories exist"

  if [ssh -t $SSH_ALIAS -d $1]; then
    echo "Clearing: $1"
    ssh $SSH_ALIAS "sudo -S rm -r $1/*"
  else
    echo "Creating: $1"
    ssh -t $SSH_ALIAS "sudo bash -c 'mkdir -p $1 && chown -R $SSH_USER: $1'"
  fi
}

check_remote_dir_exists $SERVER_REMOTE_DIR
check_remote_dir_exists $CLIENT_REMOTE_DIR

echo "Building and copying server files..."
echo $SERVER_HOST_DIR
cd $SERVER_HOST_DIR && scp -Cr ./ $SSH_ALIAS:$SERVER_REMOTE_DIR
echo "Building and transfering server done!"

echo "Building and transfering client files, cert and ngingx config..."
echo $CLIENT_HOST_DIR
cd $CLIENT_HOST_DIR && npm run build
scp -Cr $CLIENT_HOST_DIR/build/* my-cert.{crt,key} nginx.conf $SSH_ALIAS:$CLIENT_REMOTE_DIR
echo "Building and transfering done!"
