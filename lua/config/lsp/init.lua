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
    -- basedpyright = {},
    ty = {},
    sqls = {},
    cssls = {},
    html = {},
    tombi = {},
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
    zls = {}
}


for name, config in pairs(lsps) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name, true)
end


local function format()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
end

vim.api.nvim_create_user_command("Format", format, {
    nargs = 0,
    desc = "format buffer"
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        require("config.lsp.keymaps").set_keymaps()
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
        })
    end,
})
