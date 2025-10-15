#! /bin/sh

DOTS_DIR="${HOME}/dots"

DOTS_NVIM_PARENT_DIR="${HOME}/.config"
DOTS_NVIM_DIR="${DOTS_NVIM_PARENT_DIR}/nvim"

DOTS_ZSH_PATH="${HOME}/.zshrc"

DOTS_TMUX_PATH="${HOME}/.tmux.conf"

DOTS_ALACRITTY_PARENT_DIR="${HOME}/.config/alacritty"
DOTS_ALACRITTY_PATH="${DOTS_ALACRITTY_PARENT_DIR}/alacritty.toml"

DOTS_GHOSTTY_PARENT_DIR="${HOME}/.config/ghostty"
DOTS_GHOSTTY_PATH="${DOTS_GHOSTTY_PARENT_DIR}/config"

DOTS_HELIX_PARENT_DIR="${HOME}/.config/helix"
DOTS_HELIX_PATH="${DOTS_HELIX_PARENT_DIR}/config.toml"

DOTS_CLAUDE_DIR="${HOME}/.claude"
DOTS_CLAUDE_SETTINGS_PATH="${DOTS_CLAUDE_DIR}/settings.json"
DOTS_CLAUDE_STATUSLINE_PATH="${DOTS_CLAUDE_DIR}/statusline-command.sh"
DOTS_SOUNDS_DIR="${HOME}/Library/Sounds"

git submodule update --init --recursive

# inits zsh
echo 'initialising zsh...'
(rm "${DOTS_ZSH_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/zsh/.zshrc" "${DOTS_ZSH_PATH}"
echo 'done!'

# inits zsh
echo 'initialising tmux...'
(rm "${DOTS_TMUX_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/tmux/.tmux.conf" "${DOTS_TMUX_PATH}"
echo 'done!'

# inits nvim
echo 'initialising nvim'
mkdir -p "${DOTS_NVIM_PARENT_DIR}"
(rm -rf "${DOTS_NVIM_DIR}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/nvim" "${DOTS_NVIM_DIR}"
echo 'done!'

# inits alacritty
echo 'initialising alacritty...'
mkdir -p "${DOTS_ALACRITTY_PARENT_DIR}"
(rm -f "${DOTS_ALACRITTY_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/alacritty/alacritty.toml" "${DOTS_ALACRITTY_PATH}"
echo 'done!'

echo 'initialising ghossty...'
mkdir -p "${DOTS_GHOSTTY_PARENT_DIR}"
(rm -f "${DOTS_GHOSTTY_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/ghostty/config" "${DOTS_GHOSTTY_PATH}"
echo 'done!'

echo 'initialising helix...'
mkdir -p "${DOTS_HELIX_PARENT_DIR}"
(rm -f "${DOTS_HELIX_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/helix/config.toml" "${DOTS_HELIX_PATH}"
echo 'done!'                                                                                                             # inits claude
echo 'initialising claude...'
mkdir -p "${DOTS_CLAUDE_DIR}"
(rm -f "${DOTS_CLAUDE_SETTINGS_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/claude/settings.json" "${DOTS_CLAUDE_SETTINGS_PATH}"
(rm -f "${DOTS_CLAUDE_STATUSLINE_PATH}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/claude/statusline-command.sh" "${DOTS_CLAUDE_STATUSLINE_PATH}"
echo 'done!'

# copy sound files to Library/Sounds (macOS only)
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo 'copying sound files to Library/Sounds...'
    mkdir -p "${DOTS_SOUNDS_DIR}"
    cp "${DOTS_DIR}/claude/sounds/"*.mp3 "${DOTS_SOUNDS_DIR}/" 2>/dev/null || echo 'No mp3 files to copy or already exist'
    echo 'done!'
fi
