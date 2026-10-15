--------------------------------------------------
-- CORE
--------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.signcolumn = "yes"

opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

opt.undofile = true

opt.updatetime = 250
opt.timeoutlen = 400

opt.termguicolors = true


--------------------------------------------------
-- MINI.NVIM
--------------------------------------------------

require("mini.icons").setup()

require("mini.files").setup({
    options = {
        use_as_default_explorer = true,
    },

    windows = {
        preview = true,

        width_focus = 30,
        width_nofocus = 18,
        width_preview = 42,
    },
})

require("mini.pick").setup()

require("mini.statusline").setup({
    use_icons = true,
})

require("mini.pairs").setup()


--------------------------------------------------
-- KEYMAPS
--------------------------------------------------

local map = vim.keymap.set


-- Save / quit

map(
    "n",
    "<leader>w",
    "<cmd>write<cr>",
    { desc = "Save file" }
)

map(
    "n",
    "<leader>q",
    "<cmd>quit<cr>",
    { desc = "Quit window" }
)


-- File explorer

map(
    "n",
    "<leader>e",
    function()
        local path = vim.api.nvim_buf_get_name(0)

        if path == "" then
            path = vim.fn.getcwd()
        else
            path = vim.fs.dirname(path)
        end

        MiniFiles.open(path, true)
    end,
    { desc = "File explorer" }
)


-- Find files

map(
    "n",
    "<leader>ff",
    function()
        MiniPick.builtin.files()
    end,
    { desc = "Find files" }
)


-- Search text throughout project

map(
    "n",
    "<leader>fg",
    function()
        MiniPick.builtin.grep_live()
    end,
    { desc = "Search project" }
)


-- Open existing buffers

map(
    "n",
    "<leader>fb",
    function()
        MiniPick.builtin.buffers()
    end,
    { desc = "Find buffers" }
)


-- Window navigation

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


-- Clear search highlighting

map(
    "n",
    "<Esc>",
    "<cmd>nohlsearch<cr>"
)


--------------------------------------------------
-- PALETTE
--------------------------------------------------

local bg        = "#0f1018"
local bg_alt    = "#161823"
local selection = "#202337"

local fg        = "#f4f1ff"
local muted     = "#85899b"
local dim       = "#696278"

local pink      = "#f29ac3"
local lavender  = "#c6a0f6"
local blue      = "#8aadf4"
local cyan      = "#7dcfe3"

local orange    = "#eca46a"
local red       = "#ff5c8a"


--------------------------------------------------
-- BASE HIGHLIGHTS
--------------------------------------------------

local hl = vim.api.nvim_set_hl

hl(0, "Normal", {
    fg = fg,
    bg = bg,
})

hl(0, "NormalFloat", {
    fg = fg,
    bg = bg_alt,
})

hl(0, "FloatBorder", {
    fg = lavender,
    bg = bg_alt,
})

hl(0, "CursorLine", {
    bg = bg_alt,
})

hl(0, "LineNr", {
    fg = dim,
})

hl(0, "CursorLineNr", {
    fg = pink,
    bold = true,
})

hl(0, "Visual", {
    bg = selection,
})

hl(0, "Search", {
    fg = bg,
    bg = pink,
})

hl(0, "IncSearch", {
    fg = bg,
    bg = cyan,
})

hl(0, "Comment", {
    fg = muted,
    italic = true,
})

hl(0, "String", {
    fg = cyan,
})

hl(0, "Number", {
    fg = pink,
})

hl(0, "Boolean", {
    fg = pink,
})

hl(0, "Function", {
    fg = blue,
})

hl(0, "Identifier", {
    fg = fg,
})

hl(0, "Keyword", {
    fg = lavender,
})

hl(0, "Statement", {
    fg = lavender,
})

hl(0, "Type", {
    fg = pink,
})

hl(0, "Constant", {
    fg = cyan,
})

hl(0, "Operator", {
    fg = lavender,
})

hl(0, "Directory", {
    fg = blue,
})

hl(0, "Title", {
    fg = pink,
    bold = true,
})

hl(0, "ErrorMsg", {
    fg = red,
})

hl(0, "WarningMsg", {
    fg = orange,
})


--------------------------------------------------
-- DIAGNOSTICS
--------------------------------------------------

hl(0, "DiagnosticError", {
    fg = red,
})

hl(0, "DiagnosticWarn", {
    fg = orange,
})

hl(0, "DiagnosticInfo", {
    fg = blue,
})

hl(0, "DiagnosticHint", {
    fg = cyan,
})


--------------------------------------------------
-- COMPLETION MENU
--------------------------------------------------

hl(0, "Pmenu", {
    fg = fg,
    bg = bg_alt,
})

hl(0, "PmenuSel", {
    fg = pink,
    bg = selection,
})


--------------------------------------------------
-- MINI.FILES
--------------------------------------------------

hl(0, "MiniFilesDirectory", {
    fg = blue,
})

hl(0, "MiniFilesFile", {
    fg = fg,
})

hl(0, "MiniFilesBorder", {
    fg = lavender,
    bg = bg,
})

hl(0, "MiniFilesTitle", {
    fg = muted,
    bg = bg,
})

hl(0, "MiniFilesTitleFocused", {
    fg = pink,
    bg = bg,
    bold = true,
})


--------------------------------------------------
-- MINI.PICK
--------------------------------------------------

hl(0, "MiniPickNormal", {
    fg = fg,
    bg = bg_alt,
})

hl(0, "MiniPickBorder", {
    fg = lavender,
    bg = bg_alt,
})

hl(0, "MiniPickPrompt", {
    fg = pink,
    bg = bg_alt,
})

hl(0, "MiniPickMatchCurrent", {
    fg = pink,
    bg = selection,
})

hl(0, "MiniPickMatchRanges", {
    fg = cyan,
})


--------------------------------------------------
-- MINI.STATUSLINE
--------------------------------------------------

hl(0, "MiniStatuslineModeNormal", {
    fg = bg,
    bg = blue,
    bold = true,
})

hl(0, "MiniStatuslineModeInsert", {
    fg = bg,
    bg = cyan,
    bold = true,
})

hl(0, "MiniStatuslineModeVisual", {
    fg = bg,
    bg = lavender,
    bold = true,
})

hl(0, "MiniStatuslineModeReplace", {
    fg = bg,
    bg = red,
    bold = true,
})

hl(0, "MiniStatuslineModeCommand", {
    fg = bg,
    bg = pink,
    bold = true,
})

hl(0, "MiniStatuslineDevinfo", {
    fg = muted,
    bg = bg_alt,
})

hl(0, "MiniStatuslineFilename", {
    fg = fg,
    bg = bg_alt,
})

hl(0, "MiniStatuslineFileinfo", {
    fg = muted,
    bg = bg_alt,
})

hl(0, "MiniStatuslineInactive", {
    fg = dim,
    bg = bg_alt,
})


--------------------------------------------------
-- LANGUAGE INTELLIGENCE
--------------------------------------------------

require("core.treesitter")
require("core.lsp")
require("core.cheatsheet")
