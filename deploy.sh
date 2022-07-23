#!/bin/bash -eux

function deploy () {
  for file in "$(find /home/isucon/webapp/all -type f)"; do
    sudo cp $file $(echo $file | sed "s/\/home\/isucon\/webapp\/all//")
  done
  for file in "$(find /home/isucon/webapp/$HOSTNAME -type f)"; do
    sudo cp $file $(echo $file | sed "s/\/home\/isucon\/webapp\/$HOSTNAME//")
  done

  (cd /home/isucon/webapp/go && go build -o app)

  sudo systemctl restart nginx
  sudo systemctl restart mysql
  sudo systemctl restart isucon.go

  sudo sysctl -p /etc/sysctl.d/99-isucon.conf
  
  # refresh
  source /home/isucon/webapp/deploy.sh
}

function sync () {
  git fetch && \
  git reset --hard origin/$1 # <username>/<branch_name>
}