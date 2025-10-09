local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason = require("mason")
local saga = require("lspsaga")
local null_ls = require("null-ls")
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		swift = { "swift_format" },
	},
})

null_ls.setup({
	sources = {
		-- null_ls.builtins.formatting.black,
		-- null_ls.builtins.formatting.ruff,
		require("none-ls.diagnostics.flake8"),
		require("none-ls.formatting.ruff"),
		-- null_ls.builtins.diagnostics.pylint
		-- null_ls.extras.diagnostics.flake8
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
--
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
	vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- got to declaration
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
end

local capabilities = cmp_nvim_lsp.default_capabilities()

mason.setup()
mason_lspconfig.setup({
	ensure_installed = { "lua_ls" },
})

vim.lsp.enable("sourcekit")
vim.lsp.config("*", {
	on_attach = on_attach,
	capabilities = capabilities,
})

require("flutter-tools").setup({
	lsp = {
		on_attach = on_attach,
		capabilities = capabilities,
	},
})
