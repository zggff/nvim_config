vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

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
    inlayHints = {},
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN
        }
    },
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

local util = require("lspconfig.util")

local lsps = {
    clangd = {},
    sourcekit = {
        filetypes = { "swift" },
        root_dir = function(fname)
            return util.root_pattern("Package.swift", ".git")(fname)
        end,
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
    -- filepaths_ls = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                check = {
                    command = "clippy",
                },
            }
        }
    },
    -- pyrefly = {},
    basedpyright = {},
    sqls = {},
    cssls = {},
    html = {},
    tombi = {},
    -- metal_lsp = {
    --     cmd = { "metal-lsp" },
    --     filetypes = { 'metal' },
    --     settings = {},
    -- },
    efm = {
        init_options = { documentFormatting = true },
        settings = {
            languages = {
                python = {
                    { formatCommand = "ruff format --stdin-filename ${INPUT} -", formatStdin = true, formatCanRange = false }
                }
            }
        }
    },
    jdtls = {},
    zls = {},
    dart = {},
    tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" }
    },
    bashls = {},
    -- basics_ls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for name, config in pairs(lsps) do
    config.capabilities = capabilities
    vim.lsp.config(name, config)
    vim.lsp.enable(name, true)
end

-- weird workaround to allow neovim to use luasnip for snippets
---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.expand = function(trigger)
    require('luasnip').lsp_expand(trigger)
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
    if filter and filter.direction then
        return require('luasnip').jumpable(filter.direction)
    end
    return require('luasnip').in_snippet()
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
    require('luasnip').jump(direction)
end


vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format() end, {
    nargs = 0,
    desc = "format buffer"
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        require("luasnip.loaders.from_vscode").lazy_load()
        require("config.lsp.keymaps").set_keymaps()
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
        })
    end,
})
