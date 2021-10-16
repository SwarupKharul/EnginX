#!/bin/bash

# source logger
LOGGER="logger"
. ${LOGGER}.sh

DOCKER_PORT=8000

# Start docker
function start_docker() {
    # if docker is not installed then install it
    if ! command -v docker >/dev/null 2>&1; then
        e_warning "Docker is not installed. Installing it now..."
        sudo apt install -y docker
        e_success "Docker is installed."
    fi

    # if docker-compose is not installed then install it
    if ! command -v docker-compose >/dev/null 2>&1; then
        e_warning "Docker-compose is not installed. Installing it now..."
        sudo apt install -y docker-compose
        e_success "Docker-compose is installed."
    fi
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

function run_docker_image(){
    if [ -f "docker-compose.yml" ]; then
        # Run docker image
        e_arrow "Running docker image...."
        sudo docker-compose up -d
        e_success "Docker image running"
    else
        e_error "docker-compose.yml not found"
        # Run docker image
        e_arrow "Running docker image...."
        sudo docker run -d -p ${DOCKER_PORT}:${DOCKER_PORT} ${DOCKER_IMAGE}
        e_success "Docker image running"
    fi
}