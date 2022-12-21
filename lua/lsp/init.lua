local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

local mason_status, mason = pcall(require, "mason");
if not mason_status then
    return
end

local null_ls_status, null_ls = pcall(require, "null-ls");
if not null_ls_status then
    return
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.prettier
    }
})

local keymap = vim.keymap

local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
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



local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    -- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    -- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
    -- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end


-- local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities()


mason.setup();
mason_lspconfig.setup({
    ensure_installed = { "sumneko_lua" }
})

function set_rust_target(target)
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
                        --     allFeatures = true,
                        --     overrideCommand = {
                        --         'cargo', 'clippy', '--workspace', '--message-format=json',
                        --         '--all-targets', '--all-features'
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

vim.cmd([[ command! RustWasm32 lua set_rust_target("wasm32-unknown-unknown")]])
vim.cmd([[ command! RustMacos lua set_rust_target("aarch64-apple-darwin") ]])




mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["sumneko_lua"] = function()
        -- local opts = {
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        -- }
        -- local sumneko_opts = require("lsp.settings.sumneko_lua")
        lspconfig["sumneko_lua"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        })
        -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
        -- lspconfig["sumneko_lua"].setup(opts)
    end,
    ["rust_analyzer"] = function()

        set_rust_target("aarch64-apple-darwin")
        -- require("rust-tools").setup({
        --     tools = {
        --         reload_workspace_from_cargo_toml = true,
        --         inlay_hints = {
        --             show_parameter_hints = true,
        --         },
        --     },
        --     server = {
        --         experimental = {
        --             procAttrMacros = true,
        --         },
        --         settings = {
        --             ["rust-analyzer"] = {
        --                 cargo = {
        --                     target = "wasm32-unknown-unknown"
        --                 },
        --                 -- checkOnSave = {
        --                 --     enable = true,
        --                 --     allTargets = false,
        --                 --
        --                 -- },
        --             },
        --         },
        --         on_attach = on_attach,
        --         capabilities = capabilities,
        --         standalone = true,
        --     }
        -- })
    end
})

-- TODO: figure out how to make sourcekit work
-- lspconfig.sourcekit.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     command = "$SWIFT/sourcekit-lsp",
--     -- filetypes = { "" },
--     -- autostart = false,
--     filetypes = { "swift" }
--
-- })
