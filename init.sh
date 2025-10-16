#! /bin/sh

ln -s . ${HOME}/.config


# copy sound files to Library/Sounds (macOS only)
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo 'copying sound files to Library/Sounds...'
    mkdir -p "${DOTS_SOUNDS_DIR}"
    cp "${DOTS_DIR}/claude/sounds/"*.mp3 "${DOTS_SOUNDS_DIR}/" 2>/dev/null || echo 'No mp3 files to copy or already exist'
    echo 'done!'
fi
