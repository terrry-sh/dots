

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"


-- Tab stuff
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- Colors
vim.opt.termguicolors = true
-- syntax on is for free


-- Indenting behaviour of the next line
vim.opt.smartindent = true


-- Hidden: Can you open a new character buffer with unsaved work "hidden" ie not currently on the screen
vim.opt.hidden = true

-- Errorbells: alerts for errors
vim.opt.errorbells = false


-- Search highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true


-- CURSOR BEHAVIOUR

-- Nice cursor line
vim.opt.cursorline = true
-- Keeps the cursor centred with lines
-- Ie when within 8 lines of the extremities
-- turn off scroll
vim.opt.scrolloff = 8




-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50


-- NEOVIM does this for free
-- you can backspace over indentation, eol, start
-- from the web "The backspace default is absurd, you are going to want to add all of the above to your Vim settings."
-- set backspace=indent,eol,start
-- set encoding=UTF-8
-- filetype plugin indent on
-- we do not support ancient vims 
-- set nocompatible


-- Add mouse support
vim.opt.mouse='a'

vim.cmd(
    [[
        colorscheme pinkmare
        "--- hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#87c095 guifg=NONE
    ]]
)