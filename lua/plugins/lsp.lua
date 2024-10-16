local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason = require("mason");
local saga = require("lspsaga")
local null_ls = require("null-ls")


null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
    }
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

local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = true,
    severity_sort = true,
})



local on_attach = function(_, _)
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                     -- show definition, references
    vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)                -- got to declaration
    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                -- see definition and make edits in window
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)       -- go to implementation
    vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
    vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end


local capabilities = cmp_nvim_lsp.default_capabilities()


mason.setup();
mason_lspconfig.setup({
    ensure_installed = { "lua_ls" }
})

function SetRustTarget(target)
    require("rust-tools").setup({
        tools = {
            reload_workspace_from_cargo_toml = true,
            inlay_hints = {
                show_parameter_hints = true,
            },
        },
        server = {
            experimental = {
                procAttrMacros = true,
            },
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy"
                    },

                    cargo = {
                        target = target
                    },
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
            standalone = true,
        }
    })
end

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["lua_ls"] = function()
        lspconfig["lua_ls"].setup {
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- Depending on the usage, you might want to add additional paths here.
                            "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["rust_analyzer"] = function()
        SetRustTarget("aarch64-apple-darwin")
    end
})
