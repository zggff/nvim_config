require('lspkind').setup({
    mode = "symbol"
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
    vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, opts)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
    })
end


local lsps = { "clangd", "sourcekit", "lua_ls", "gopls", "rust_analyzer", "pyrefly", "filepaths_ls", "sqls" }
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
