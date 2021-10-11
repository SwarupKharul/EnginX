#!/bin/bash

# source logger
LOGGER="logger"
. ${LOGGER}.sh


# Start docker
function start_docker() {
    # Start docker
    e_arrow "Starting docker...."
    sudo service docker start
    e_success "Docker started"
}

# Build docker image
function build_docker_image() {
    # check if docker-compose.yml exists
    if [ -f "docker-compose.yml" ]; then
        # Build docker image
        e_arrow "Building docker image...."
        sudo docker-compose build
        e_success "Docker image built"
    else
        e_error "docker-compose.yml not found"
        # Use Dockerfile to build image
        e_arrow "Building docker image...."
        sudo docker build -t ${DOCKER_IMAGE} .
        e_success "Docker image built"
    fi

}
