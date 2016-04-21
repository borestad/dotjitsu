docker.ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

docker.ips() {
  docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
}

docker.ips2() {
  docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

docker.rmf() {
  docker rm -f $(docker ps -qa)
}

docker:info() {
    docker ps | while read line; do
        if `echo $line | grep -q 'CONTAINER ID'`; then
            echo -e "IP ADDRESS\t$line"
        else
            CID=$(echo $line | awk '{print $1}');
            IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $CID);
            printf "${IP}\t${line}\n"
        fi
    done;
}
