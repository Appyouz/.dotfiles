#!/bin/bash
# Function to find and activate .venv up to the project root
activate_venv() {
    local dir=$(pwd)
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/.venv/bin/activate" ]; then
            source "$dir/.venv/bin/activate"
            return 0
        fi
        if [ -d "$dir/.git" ]; then
            return 1  # No .venv found up to project root
        fi
        dir=$(dirname "$dir")
    done
}

# Activate venv if it exists
activate_venv
exec "$@"
