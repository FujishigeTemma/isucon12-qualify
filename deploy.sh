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
