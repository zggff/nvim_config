local saga = require("lspsaga")
local null_ls = require("null-ls")

require('lspkind').setup({
    mode = "symbol"
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.yapf,
    },
})

saga.setup({
    symbol_in_winbar = {
        enable = false,
    },
    lightbulb = {
        enable = false,
        virtual_text = false,
        enable_in_insert = false,
    },
})

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        }
    },
    underline = false,
    update_in_insert = true,
    severity_sort = true,
})

local on_attach_default = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)           -- show definition, references
    vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)      -- got to declaration
    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)      -- see definition and make edits in window
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)             -- show documentation for what is under cursor
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, opts)           -- show documentation for what is under cursor
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
    })
end


local lsps = { "clangd", "sourcekit", "lua_ls", "gopls", "jedi_language_server", "rust_analyzer", "sourcekit" }
for _, name in ipairs(lsps) do
    vim.lsp.enable(name)
    vim.lsp.config(name, {
        on_attach = on_attach_default,
    })
end

vim.lsp.config("sourcekit", {
    filetypes = { "swift" },
})

vim.lsp.config("rust_analyzer", {
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                local abbr = item.label:gsub("%b()", "") -- remove parentheses
                local info = string.format("```rust\n%s\n```", item.detail)
                if item.documentation ~= nil then
                    info = info .. "\n\n" .. item.documentation.value
                end
                return {
                    abbr = abbr,
                    menu = "",
                    info = info,
                }
            end,
        })
        on_attach_default(client, bufnr)
    end
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

local function format()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
end

vim.api.nvim_create_user_command("Format", format, {
    nargs = 0,
    desc = "format buffer"
})
