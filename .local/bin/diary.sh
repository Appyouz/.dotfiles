#!/bin/bash

# Config
NOTE_FILE="$HOME/notes/journal/diary/my_notes.md.gpg"
TEMP_FILE=$(mktemp /tmp/secure_note.XXXXXX)

# If file exists, decrypt it first
if [[ -f "$NOTE_FILE" ]]; then
    gpg -d "$NOTE_FILE" > "$TEMP_FILE" || exit 1
else
    touch "$TEMP_FILE"
fi

# Open in nano (you can change to vim, micro, etc.)
nvim "$TEMP_FILE"

# Re-encrypt after editing
gpg -c --output "$NOTE_FILE" "$TEMP_FILE" || {
    echo "Error: failed to encrypt. Keeping temp file at $TEMP_FILE"
    exit 1
}

# Securely delete temp file
shred -u "$TEMP_FILE"

echo "✅ Notes saved and encrypted in $NOTE_FILE"
