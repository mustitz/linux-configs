# Get the directory where this script is located
MUSTITZ_CONFIG_DIR=$(dirname "${BASH_SOURCE[0]}")

# Useful my command - shows servers and helpful commands
my() {
    python3 "$MUSTITZ_CONFIG_DIR/my.py"
}

# Change environment: projects and python venvs
chenv() {
    if [ -f "$HOME/.chenv.sh" ]; then
        rm "$HOME/.chenv.sh"
    fi

    python3 "$MUSTITZ_CONFIG_DIR/chenv.py" "$@"

    if [ -f "$HOME/.chenv.sh" ]; then
        source "$HOME/.chenv.sh"
        rm "$HOME/.chenv.sh"
    fi
}
