#!/bin/sh

# open .gitignore and check whether venv is already in it
# if not, add it
add_venv() {
    if ! grep -q "venv" .gitignore; then
        echo "Adding venv to .gitignore"
        echo "venv" >> .gitignore
    fi
}

# check whether .git directory exists
check_git_dir() {
    if [ ! -d .git ]; then
        echo "This is not a git repository"
        return 0
    else
        echo "This is a git repository"
        return 1
    fi
}

# make virtualenv venv
make_venv() {
    if [ ! -d venv ]; then
        echo "Making virtualenv venv"
        python3 -m venv venv
    fi
}

# activate venv
activate_venv() {
    PWD=`pwd`
    echo $PWD
    echo "Activating virtualenv venv"
    echo "$PWD/venv/bin/activate"
    . "$PWD/venv/bin/activate"
}

# alias activate = ". venv/bin/activate"

# install requirements
install_requirements() {
    pip3 install -r requirements.txt
}

# Start django server
start_server(){ 
    python3 manage.py runserver
}

if [[ "$1" == "start" ]]; then
    if [check_git_dir]; then
        add_venv
    fi
    make_venv
    activate_venv
    # install_requirements
    # start_server
elif [[ "$1" == "run" ]]; then
    activate_venv
    # start_server
fi






