#!/bin/bash

err=false

if [[ ! $(sudo -l) ]]; then 
  echo -e "Add this line to /etc/sudoers:\n$(whoami)	ALL=(ALL) NOPASSWD:ALL"
  err=true
fi 

if ! ${err}; then
  read -n1 -p "Do want update system? [N,y]" doit
  case $doit in
    y|Y) sudo apt-get update && apt-get upgrade ;;
    *) echo "Skipping update" ;;
  esac
fi

for i in vim vimrc gitignore; do
  ln -s -f -n $(pwd)/${i} ~/.${i}
done

cp ./gitconfig ~/.gitconfig

echo "Decrypting ssh config:"

openssl enc -aes-256-cbc -salt -d -in ./ssh_config.enc -out /tmp/ssh_config
if [ $? -eq 0 ]; then
  mkdir -p ~/.ssh
  mv /tmp/ssh_config ~/.ssh/config
else
  rm -f /tmp/ssh_config
fi
