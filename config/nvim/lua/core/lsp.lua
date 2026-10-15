--------------------------------------------------
-- LSP
--------------------------------------------------

local map = vim.keymap.set


--------------------------------------------------
-- DIAGNOSTICS
--------------------------------------------------

vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
        prefix = "●",
    },

    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,

    float = {
        border = "single",
        source = true,
    },
})


--------------------------------------------------
-- COMPLETION
--------------------------------------------------

vim.opt.completeopt = {
    "menuone",
    "noselect",
    "popup",
}


--------------------------------------------------
-- WHEN AN LSP ATTACHES
--------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup(
        "core-lsp",
        { clear = true }
    ),

    callback = function(event)
        local client =
            vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        local opts = {
            buffer = event.buf,
            silent = true,
        }


        ------------------------------------------
        -- NAVIGATION
        ------------------------------------------

        map(
            "n",
            "gd",
            vim.lsp.buf.definition,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Go to definition" }
            )
        )

        map(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Go to declaration" }
            )
        )

        map(
            "n",
            "K",
            vim.lsp.buf.hover,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Hover documentation" }
            )
        )


        ------------------------------------------
        -- CODE
        ------------------------------------------

        map(
            "n",
            "<leader>cr",
            vim.lsp.buf.rename,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Rename symbol" }
            )
        )

        map(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Code action" }
            )
        )

        map(
            "n",
            "<leader>cf",
            function()
                vim.lsp.buf.format({
                    async = true,
                })
            end,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Format file" }
            )
        )


        ------------------------------------------
        -- DIAGNOSTICS
        ------------------------------------------

        map(
            "n",
            "<leader>cd",
            vim.diagnostic.open_float,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Show diagnostic" }
            )
        )

        map(
            "n",
            "]d",
            function()
                vim.diagnostic.jump({
                    count = 1,
                    float = true,
                })
            end,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Next diagnostic" }
            )
        )

        map(
            "n",
            "[d",
            function()
                vim.diagnostic.jump({
                    count = -1,
                    float = true,
                })
            end,
            vim.tbl_extend(
                "force",
                opts,
                { desc = "Previous diagnostic" }
            )
        )


        ------------------------------------------
        -- NATIVE COMPLETION
        ------------------------------------------

        if client:supports_method(
            "textDocument/completion"
        ) then
            vim.lsp.completion.enable(
                true,
                client.id,
                event.buf,
                {
                    autotrigger = true,
                }
            )
        end
    end,
})


--------------------------------------------------
-- MANUAL COMPLETION
--------------------------------------------------

map(
    "i",
    "<C-Space>",
    function()
        vim.lsp.completion.get()
    end,
    { desc = "Trigger completion" }
)


--------------------------------------------------
-- COMPLETION MENU
--------------------------------------------------

map(
    "i",
    "<Tab>",
    function()
        if vim.fn.pumvisible() == 1 then
            return "<C-n>"
        end

        return "<Tab>"
    end,
    {
        expr = true,
        desc = "Next completion",
    }
)

map(
    "i",
    "<S-Tab>",
    function()
        if vim.fn.pumvisible() == 1 then
            return "<C-p>"
        end

        return "<S-Tab>"
    end,
    {
        expr = true,
        desc = "Previous completion",
    }
)


--------------------------------------------------
-- LUA SERVER
--------------------------------------------------

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },

            diagnostics = {
                globals = {
                    "vim",
                },
            },

            workspace = {
                checkThirdParty = false,
            },

            telemetry = {
                enable = false,
            },
        },
    },
})


--------------------------------------------------
-- ENABLE SERVERS IF INSTALLED
--------------------------------------------------

local servers = {
    {
        name = "nil_ls",
        command = "nil",
    },

    {
        name = "lua_ls",
        command = "lua-language-server",
    },

    {
        name = "gopls",
        command = "gopls",
    },

    {
        name = "pyright",
        command = "pyright-langserver",
    },

    {
        name = "rust_analyzer",
        command = "rust-analyzer",
    },

    {
        name = "clangd",
        command = "clangd",
    },

    {
        name = "ts_ls",
        command = "typescript-language-server",
    },
}


for _, server in ipairs(servers) do
    if vim.fn.executable(server.command) == 1 then
        vim.lsp.enable(server.name)
    end
end
