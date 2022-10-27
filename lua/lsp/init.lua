local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local handlers = require("lsp.handlers")
require("mason").setup()

mason_lspconfig.setup({
    ensure_installed = { "sumneko_lua" }
})


mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }
    end,

    ["als"] = function()
        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
            settings = {
                ada = {
                }
            }
        }
        lspconfig["als"].setup(opts)

    end,
    ["sumneko_lua"] = function()
        local opts = {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }
        local sumneko_opts = require("lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
        lspconfig["sumneko_lua"].setup(opts)
    end,
    ["rust_analyzer"] = function()
        require("rust-tools").setup({
            tools = {
                hover_with_actions = false,
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                },
            },
            server = {
                on_attach = handlers.on_attach,
                capabilities = handlers.capabilities,
                standalone = true,
            }
        })
    end
})


handlers.setup()
require("lsp.null-ls")
