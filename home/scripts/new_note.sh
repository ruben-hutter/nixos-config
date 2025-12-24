#!/usr/bin/env bash
# Simple note-taking script
# Creates a new note in ~/notes/ with timestamp

NOTES_DIR="$HOME/notes"
mkdir -p "$NOTES_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
NOTE_FILE="$NOTES_DIR/note_$TIMESTAMP.md"

# Create note with header
cat > "$NOTE_FILE" <<EOF
# Note - $(date +"%Y-%m-%d %H:%M:%S")

EOF

# Open in neovim
nvim "+ normal G" "$NOTE_FILE"
