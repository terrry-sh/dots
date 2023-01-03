#! /bin/sh

DOTS_DIR="${HOME}/dots"

DOTS_NVIM_PARENT_DIR="${HOME}/.config"
DOTS_NVIM_DIR="${DOTS_NVIM_PARENT_DIR}/nvim"

DOTS_ZSH_PATH="${HOME}/.zshrc"

DOTS_TMUX_PATH="${HOME}/.tmux.conf"

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
(rm -f "${DOTS_NVIM_DIR}" || echo 'Ignoring fail'; true) && ln -s "${DOTS_DIR}/nvim" "${DOTS_NVIM_DIR}"
echo 'done!'
