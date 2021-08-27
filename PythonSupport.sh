#!/bin/sh

# source logger
LOGGER="logger"
source ${LOGGER}.sh

# open .gitignore and check whether venv is already in it
# if not, add it
add_venv() {
    if ! grep -q "venv" .gitignore; then
        echo "venv" >> .gitignore
        e_success "Added venv to .gitignore"
    fi
}

# check whether .git directory exists
check_git_dir() {
    if [ ! -d .git ]; then
        e_heading "This is not a git repository"
        return 0
    else
        e_success "This is a git repository"
        return 1
    fi
}

# make virtualenv venv
make_venv() {
    if [ ! -d venv ]; then
        sudo virtualenv venv
        e_success "virtualenv venv created successfully"
    fi
}

# activate venv
activate_venv() {
    PWD=`pwd`
    source venv/bin/activate
    e_success "Activated virtualenv venv"
}

# alias activate = ". venv/bin/activate"

# install requirements
install_requirements() {
    # make sure requirements.txt exists
    if [ ! -f requirements.txt ]; then
        e_error "requirements.txt does not exist"
        exit 1
    pip3 install -r requirements.txt
}

# check python version
check_python_version() {
    # check whether python3 is installed
    if ! which python3 > /dev/null; then
        e_warning "Python3 is not installed"
        e_arrow "Installing python3"
        sudo apt-get install python3
        sudo apt-get install python3-pip
        e_success "Python3 installed successfully"
    fi
}

check_virtualenv(){
    # check whether virtualenv is installed
    if ! which virtualenv > /dev/null; then
        e_warning "Virtualenv is not installed"
        e_arrow "Installing virtualenv"
        sudo pip3 install virtualenv
        sudo apt-get install python3-venv -y
        e_success "Virtualenv installed successfully"
    fi
}

# Start django server
start_django_server(){ 
    python3 manage.py runserver
}

# Start Flask server
start_flask_server(){
    flask run
}

# Setup up environment for django project 
django_start(){
            if check_git_dir; then
                add_venv
            fi
            make_venv
            activate_venv
            install_requirements
            start_django_server
}

# Setup up django project
django_startproject(){
    e_header "Setting up your Engine"
    PWD=`pwd`
    if check_git_dir; then
        add_venv
    fi
    # check whether virtualenv is installed

    e_header "Setting up your virtual environment"
    check_virtualenv
    make_venv
    activate_venv
    pip3 install django &> /dev/null
    django-admin startproject $1
    deactivate
    cd $PWD/$1
    # move venv to project
    mv ../venv .
    touch requirements.txt 
    activate_venv 
    e_heading "installing django dependencies...."
    python3 manage.py startapp $2
    e_header "You are good to go"
}

# deactivate venv
django_stop(){
        echo "Switching from venv .."
        deactivate
}

# start django server
django_run(){
    # check whether venv is activated
    if [ -z "$VIRTUAL_ENV" ]; then
        e_warning "venv is not activated"
        activate_venv
    fi
    start_django_server
}

# Setup up environment for flask project
flask_start(){
            if check_git_dir; then
                add_venv
            fi
            make_venv
            activate_venv
            install_requirements
            start_flask_server
}

flask_stop(){
        echo "Switching from venv .."
        deactivate
}

# start flask server
flask_run(){
    # check whether venv is activated
    if [ -z "$VIRTUAL_ENV" ]; then
        e_warning "venv is not activated"
        activate_venv
    fi
    start_flask_server
}
