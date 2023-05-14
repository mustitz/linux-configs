if [ -z "$MUSTITZ_PYVENV_DIR" ]; then
    export MUSTITZ_PYVENV_DIR="$HOME/venv"
fi

# Python switch to custom venv
activate_venv() {
    [ -z "$VIRTUAL_ENV" ] || deactivate
    . "$MUSTITZ_PYVENV_DIR/$1/bin/activate"
}

# Python list all current venvs
list_venv() {
    ls -1 $MUSTITZ_PYVENV_DIR
}

# Python venv management: list venvs or active one of them
mustitz_venv() {
    if [ $# -eq 0 ]; then
        list_venv
    else
        activate_venv $1
    fi
}

# Useful my commnad
my () {
    case $1 in
        "")
            echo "usage: my cmd"
            echo "Supported commands:"
            echo "  venv - python virtual environment management"
            ;;

        "venv")
            mustitz_venv $2
            ;;

        *)
            echo "Unknown command"
            ;;
    esac
}
