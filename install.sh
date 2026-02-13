#!/bin/sh
#
# Brainstomer Installer
# Installs brainstomer to ~/.claude/brainstomer/
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/moul/brainstomer/main/install.sh | sh
#   or
#   ./install.sh
#

set -e

# Install target
INSTALL_DIR="${HOME}/.claude/brainstomer"

# Source files to install
REQUIRED_DIRS="agents workflows commands references templates"

# Detect source directory
get_source_dir() {
    # First, try to find source relative to script location (works for ./install.sh)
    SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)" || SCRIPT_DIR=""

    # Check if we're in the repo (script location)
    if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/agents" ] && [ -d "$SCRIPT_DIR/workflows" ]; then
        echo "$SCRIPT_DIR"
        return
    fi

    # Check current directory
    if [ -d "./agents" ] && [ -d "./workflows" ]; then
        pwd
        return
    fi

    # No local source found - must be piped from curl, need to clone
    TEMP_DIR=$(mktemp -d)
    echo "Cloning brainstomer to temp directory..." >&2
    git clone --quiet --depth 1 https://github.com/moul/brainstomer.git "$TEMP_DIR" >&2
    echo "$TEMP_DIR"
}

# Main installation
main() {
    echo "Installing brainstomer..."
    echo ""

    SOURCE_DIR=$(get_source_dir)

    # Create install directory
    mkdir -p "$INSTALL_DIR"

    # Copy each directory
    FILE_COUNT=0
    for dir in $REQUIRED_DIRS; do
        if [ ! -d "$SOURCE_DIR/$dir" ]; then
            echo "Error: Missing source directory: $dir" >&2
            exit 1
        fi

        # Remove existing and copy fresh
        rm -rf "${INSTALL_DIR:?}/$dir"
        cp -r "$SOURCE_DIR/$dir" "$INSTALL_DIR/$dir"

        # Count files
        count=$(find "$INSTALL_DIR/$dir" -type f | wc -l)
        FILE_COUNT=$((FILE_COUNT + count))
    done

    # Validate installation
    MISSING=""
    for dir in $REQUIRED_DIRS; do
        if [ ! -d "$INSTALL_DIR/$dir" ]; then
            MISSING="$MISSING $dir"
        fi
    done

    if [ -n "$MISSING" ]; then
        echo "Error: Installation incomplete. Missing:$MISSING" >&2
        exit 1
    fi

    # Cleanup temp clone if used (SOURCE_DIR starts with /tmp)
    case "$SOURCE_DIR" in
        /tmp/*) rm -rf "$SOURCE_DIR" 2>/dev/null || true ;;
    esac

    # Success message
    echo "Installed to: $INSTALL_DIR"
    echo "Files copied: $FILE_COUNT"
    echo ""
    echo "Usage:"
    echo "  /brainstorm:new      Start new brainstorming session"
    echo "  /brainstorm:clarify  Resume clarification questions"
    echo "  /brainstorm:specs    Generate specs from clarified idea"
    echo "  /brainstorm:help     Show help and examples"
    echo ""
    echo "Installation complete!"
}

main
