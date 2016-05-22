alias d='docker'
alias d:top='docker stats'

d:ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

d:ips() {
  docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
}

d:ips2() {
  docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

d:rmf() {
  docker rm -f $(docker ps -qa)
}

d:info() {
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


# Get latest container ID
alias d:latest="docker ps -l -q"

# Get container process
alias d:ps="docker ps"

# Get process included stop container
alias d:psa="docker ps -a"

# Get images
alias d:images="docker images"

# Get container IP
alias d:ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias d:rund="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias d:runi="docker run -i -t -P"

# Stop all containers
d:stopall() { docker stop $(docker ps -a -q); }

# Remove all containers
d:rm-containers() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias d:rmf-containers='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
d:rm-images() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
d:build() { docker build -t=$1 .; }

# Show all alias related docker
d:alias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

alias -g DA='$(d:all)'
alias -g DC='$(dl:c)'
alias -g DI='$(dl:i)'
alias -g DL='$(d:latest)'

# Shortcut aliases
alias d:all='docker ps -qa'
alias d:cc='d:rm-all ; d:rm-none-image'
alias d:ex="docker exec -it"
alias d:last='d:latest'
alias d:latest='docker ps -ql'
alias d:list='d:all'
alias d:rm-all='docker rm -f DA'
alias d:rm-none-image='docker rmi $(docker images -f dangling=true -q)'
alias d:start-all='docker start DA'
alias d:stop-all='docker stop DA'

d:kill-all() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -q)
}

# Interactive docker aliases
alias dl:i="docker images | grep -v 'REPOSITORY' | fzf | awk '{print \$1}'"
alias dl:c="docker ps | grep -v 'CONTAINER ID' | fzf | awk '{print \$1}'"

alias di:attach='docker attach DC'
alias di:containers-all="docker ps -a | grep -v 'CONTAINER ID' | fzf | awk '{print \$1}'"
alias di:ex="docker exec -it DC /bin/bash"
alias di:inspect='docker inspect DI | jq'
alias di:restart='docker restart DC'
alias di:run='docker run --rm -it DI /bin/bash'

# Stop & remove container
di:rm() { container=$(dl:c) && docker stop $container && docker rm $container }
alias di:rmi='docker rmi DI'
alias di:start='docker start DC'
alias di:stop='docker stop DC'

# alias d:b='docker build --rm -t $(pwd | awk -F/ "{print \$(NF-1),\$NF}" | sed "s/ /\//g") .'

# Execute interactive container, e.g., $dex base /bin/bash
alias d:cc='d:stop-all ; d:rm-all ; d:rm-none-image'
