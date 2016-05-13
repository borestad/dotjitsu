if [[ $(pgrep docker-machine-driver-xhyve) ]]; then
  if [[ $(docker-machine status dev) == *"Running"* ]]; then
     eval $(docker-machine env dev)
  else
    echo "It looks like docker-machine did not start correctly :("
  fi
else
  echo "docker-machine dev is not running"
  echo "try running: docker-machine start dev"
fi