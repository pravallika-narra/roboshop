sp=$(pwd)

status_check(){
  if[$? -eq 0]; then
    echo "SUCCESS"
  else
    echo "FAILED"
    exit
  fi

}