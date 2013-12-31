#!/bin/bash
VENV=$1
if [ -z $VENV ]; then
    echo "usage: runinenv [virtualenv_path] CMDS"
    exit 1
fi
. ${VENV}/bin/activate
. ${VENV}/bin/postactivate
shift 1
echo "Executing $@ in ${VENV}"
exec "$@"
deactivate
