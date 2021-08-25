#!/bin/sh

PYTHON_FRAMEWORKS="PythonSupport" # Python frameworks

source "$PYTHON_FRAMEWORKS".sh # Load functions Python frameworks

case "$1" in 
    -d|--django)
        check_python_version
        if [[ "$2" == "start" ]]; then
            d_start
        elif [[ "$2" == "run" ]]; then
            d_run
        elif [[ "$2" == "stop" ]]; then
            d_stop
        fi;;
esac