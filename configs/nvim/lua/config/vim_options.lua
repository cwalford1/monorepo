local spaces_per_tab = 2
local opt = vim.o
local global = vim.g

global.mapleader = " "
global.maplocalleader = "\\"

opt.number = true                -- print the line number in front of each line
opt.relativenumber = true        -- show the line number relative to current line on other lines
opt.clipboard = "unnamedplus"    -- Use the clipboard register for ordinary yanks and pastes.
opt.autoindent = true
opt.cursorline = true            -- highlights line cursor is positioned on
opt.expandtab = true             -- Pressing the TAB key will insert spaces instead of a TAB character
opt.shiftwidth = spaces_per_tab  -- Number of spaces inserted when indenting
opt.tabstop = spaces_per_tab     -- A TAB character looks like 2 spaces
opt.softtabstop = spaces_per_tab -- Number of spaces inserted instead of a TAB character
opt.ruler = true                 -- show line and column number of cursor position
opt.showcmd = true               -- show (partial) command in the last line of the screen.
opt.inccommand =
"split"                          --??: when nonempty, shows the effects of :substitute, :smagic, and :snomagic and user commands with the :command-preview flag as you type
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true

-- PROBATION
-- options I'm testing out  / testing out removing
--
-- I recall setting this to get around some tmux jank, but it is causing the
-- paste control sequence stuck bug. Will return to default for now and see if
-- I re-discover why I had it set this way.
-- opt.ttimeoutlen = 0
