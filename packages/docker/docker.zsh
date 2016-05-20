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

# Execute interactive container, e.g., $dex base /bin/bash
alias d:ex="docker exec -i -t"

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

alias d:latest='docker ps -ql'
alias d:a='docker ps -qa'
alias d:i="docker images | grep -v 'REPOSITORY' | fzf | awk '{print \$1}'"
alias d:c="docker ps -a | grep -v 'CONTAINER ID' | fzf | awk '{print \$1}'"
alias d:b='docker build --rm -t $(pwd | awk -F/ "{print \$(NF-1),\$NF}" | sed "s/ /\//g") .'
alias d:run='docker run --rm -it $(d:i) /bin/bash'
alias d:rm='docker rm $(dc)'
alias d:start='docker start $(d:c)'
alias d:restart='docker restart $(d:c)'
alias d:stop='docker stop $(d:c)'
alias d:attach='docker attach $(d:c)'
alias d:rm-all='docker rm -f $(d:a)'
alias d:rmi='docker rmi $(d:i)'
alias d:stop-all='docker stop $(d:a)'
alias d:start-all='docker start $(d:a)'
alias d:rm-none-image='docker rmi $(docker images -f dangling=true -q)'
#alias dcc='d:stop-all ; d:rm-all ; d:rm-none-image'
alias dcc='d:rm-all ; d:rm-none-image'
