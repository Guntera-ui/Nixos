--------------------------------------------------
-- TREESITTER
--------------------------------------------------

local filetypes = {
    "nix",
    "lua",
    "bash",
    "sh",

    "go",
    "gomod",
    "gosum",

    "python",

    "json",
    "toml",
    "yaml",

    "markdown",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,

    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
