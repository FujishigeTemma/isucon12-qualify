function deploy () {
  server="$(hostname)"
  basepath="/home/isucon/webapp" # Tobe changed
  for file in "$(find all -type f)"; do
    cp basepath/$file /${file#*/}
  done
  for file in "$(find $server -type f)"; do
    cp basepath/$file /${file#*/}
  done
}
#!/bin/bash -eux

function deploy () {
  basepath="/home/isucon/webapp" # To Be Changed

  for file in "$(find all -type f)"; do
    cp $basepath/$file /${file#*/}
  done
  for file in "$(find $HOSTNAME -type f)"; do
    cp $basepath/$file /${file#*/}
  done

  (cd /home/isucon/webapp/go && go build -o app)

  # sudo systemctl restart nginx
  # sudo systemctl restart mysql
  # sudo systemctl restart isucon.go

  sudo sysctl -p /etc/sysctl.d/100-isucon.conf
  
  # refresh
  source $basepath/deploy.sh
}

function sync () {
  git fetch && \
  git reset --hard origin/$1 # <username>/<branch_name>
}