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
    eval source 
    echo "Activating virtualenv venv"
    eval source "venv/bin/activate"
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

# check python version
check_python_version() {
    # check whether python3 is installed
    if ! which python3 > /dev/null; then
        echo "Python3 is not installed"
        exit 1
    fi
    echo "Python3 is installed"
}


d_start(){
            if check_git_dir; then
                add_venv
            fi
            make_venv
            activate_venv
            install_requirements
            start_server
}

d_stop(){
        echo "Switching from venv .."
        deactivate
}

d_run(){
    activate_venv
    start_server
}
