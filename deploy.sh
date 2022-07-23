#!/bin/bash -eux

function deploy () {
  for src in "$(find /home/isucon/webapp/all -type f)"; do
    dest="$(echo $src | sed "s/\/home\/isucon\/webapp\/all//")"
    sudo cp $src $dest 
  done
  for src in "$(find /home/isucon/webapp/$HOSTNAME -type f)"; do
    dest=$(echo $src | sed "s/\/home\/isucon\/webapp\/$HOSTNAME//")
    sudo cp $src $dest
  done

  (cd /home/isucon/webapp/go && go build -o app)

  sudo systemctl restart nginx
  sudo systemctl restart mysql
  sudo systemctl restart isuports.service

  sudo sysctl -p /etc/sysctl.d/99-isucon.conf
  
  # refresh
  source /home/isucon/webapp/deploy.sh
}

function sync () {
  git fetch && \
  git reset --hard origin/$1 # <username>/<branch_name>
}