require('lspkind').setup({
    mode = "symbol"
})

local winid = nil

local function on_jump(diagnostic, bufnr)
    if not diagnostic then return end
    if winid and vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, true)
    end
    _, winid = vim.diagnostic.open_float({
        bufnr = bufnr,
        diagnostic = diagnostic,
        scope = "cursor"
    })
end

vim.diagnostic.config({
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN
        }
    },
    -- virtual_lines = {
    --     current_line = true
    -- },
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
    jump = { on_jump = on_jump }
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


local lsps = {
    clangd = {},
    sourcekit = {
        filetypes = { "swift" }
    },
    lua_ls = {},
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        },
    },
    filepaths_ls = {},
    rust_analyzer = {},
    pyrefly = {},
    sqls = {},
    cssls = {},
    html = {}
}

for name, config in pairs(lsps) do
    if config.on_attach == nil then
        config.on_attach = on_attach_default
    end
    vim.lsp.enable(name, true)
    vim.lsp.config(name, config)
end


local function format()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
end

vim.api.nvim_create_user_command("Format", format, {
    nargs = 0,
    desc = "format buffer"
})
