#! /bin/sh

DOTS_DIR="${HOME}/dots"

DOTS_NVIM_PARENT_DIR="${HOME}/.config"
DOTS_NVIM_DIR="${DOTS_NVIM_PARENT_DIR}/nvim"



git submodule update --init --recursive

# inits nvim
mkdir -p "${DOTS_NVIM_PARENT_DIR}"
ln -s "${DOTS_DIR}/nvim" "${DOTS_NVIM_DIR}"
