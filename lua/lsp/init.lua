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



local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)               -- show definition, references
    keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)          -- got to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)          -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    -- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    -- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
    -- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end


-- local client_capabilities = vim.lsp.protocol.make_client_capabilities()
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

vim.cmd([[ command! RustWasm32 lua SetRustTarget("wasm32-unknown-unknown")]])
vim.cmd([[ command! RustMacos lua SetRustTarget("aarch64-apple-darwin") ]])


mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["lua_ls"] = function()
        lspconfig["lua_ls"].setup {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["rust_analyzer"] = function()
        SetRustTarget("aarch64-apple-darwin")
    end
})

lspconfig.hls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.crystalline.setup {
    -- on_attach = on_attach,
    -- capabilities = capabilities
}
lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("package.json"),
    single_file_support = false
}

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
