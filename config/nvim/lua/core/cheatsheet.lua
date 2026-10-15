--------------------------------------------------
-- QUICK REFERENCE
--------------------------------------------------

local M = {}

local lines = {
    " NEOVIM QUICK REFERENCE ",
    "",
    " MOVEMENT",
    "   h j k l        left / down / up / right",
    "   w / b          next / previous word",
    "   e              end of word",
    "   0              start of line",
    "   ^              first non-space character",
    "   $              end of line",
    "   gg / G         top / bottom of file",
    "   f<char>        jump to character",
    "   ; / ,          repeat character jump",
    "",
    " INSERT",
    "   i / a          insert before / after cursor",
    "   I / A          insert at start / end of line",
    "   o / O          new line below / above",
    "   Esc            return to Normal mode",
    "",
    " EDITING",
    "   dd             delete line",
    "   yy             copy line",
    "   p / P          paste after / before",
    "   u              undo",
    "   Ctrl-r         redo",
    "   .              repeat last edit",
    "",
    " TEXT OBJECTS",
    "   ciw            change inside word",
    "   diw            delete inside word",
    "   yiw            copy inside word",
    "   ci\"            change inside quotes",
    "   ci(            change inside parentheses",
    "   da(            delete around parentheses",
    "",
    " SEARCH",
    "   /text          search",
    "   n / N          next / previous result",
    "",
    " FILES / PROJECT",
    "   Space e        file explorer",
    "   Space f f      find files",
    "   Space f g      search project text",
    "   Space f b      find open buffers",
    "",
    " FILE",
    "   Space w        save",
    "   Space q        close window",
    "",
    " LSP / CODE",
    "   gd             go to definition",
    "   gD             go to declaration",
    "   K              hover documentation",
    "   Space c r      rename symbol",
    "   Space c a      code action",
    "   Space c f      format file",
    "   Space c d      show diagnostic",
    "   ]d / [d        next / previous diagnostic",
    "",
    " COMPLETION",
    "   Ctrl-Space     trigger completion",
    "   Tab            next suggestion",
    "   Shift-Tab      previous suggestion",
    "   Ctrl-y         accept suggestion",
    "   Ctrl-e         close completion",
    "",
    " WINDOWS",
    "   Ctrl-h         window left",
    "   Ctrl-j         window down",
    "   Ctrl-k         window up",
    "   Ctrl-l         window right",
    "   :vsplit        vertical split",
    "   :split         horizontal split",
    "",
    " VISUAL MODE",
    "   v              character selection",
    "   V              line selection",
    "   y              copy selection",
    "   d              delete selection",
    "",
    " Press q or Esc to close ",
}

function M.open()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_lines(
        buf,
        0,
        -1,
        false,
        lines
    )

    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "help"

    local width = 58
    local height = math.min(
        #lines,
        vim.o.lines - 6
    )

    local row = math.floor(
        (vim.o.lines - height) / 2
    )

    local col = math.floor(
        (vim.o.columns - width) / 2
    )

    local win = vim.api.nvim_open_win(
        buf,
        true,
        {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,

            style = "minimal",
            border = "single",
            title = " Keys ",
            title_pos = "center",
        }
    )

    vim.wo[win].cursorline = true
    vim.wo[win].wrap = false

    local close = function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.keymap.set(
        "n",
        "q",
        close,
        {
            buffer = buf,
            silent = true,
        }
    )

    vim.keymap.set(
        "n",
        "<Esc>",
        close,
        {
            buffer = buf,
            silent = true,
        }
    )
end


--------------------------------------------------
-- COMMAND
--------------------------------------------------

vim.api.nvim_create_user_command(
    "Keys",
    M.open,
    {}
)


--------------------------------------------------
-- KEYBIND
--------------------------------------------------

vim.keymap.set(
    "n",
    "<leader>?",
    M.open,
    {
        desc = "Open quick reference",
    }
)

return M
