local cmp_nvim_lsp = require("cmp_nvim_lsp")
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

vim.diagnostic.config({
	virtual_text = true,
	signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
    },
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

vim.lsp.enable("clangd")
vim.lsp.enable("sourcekit")
vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")

vim.lsp.config("sourcekit", {
	filetypes = { "swift" },
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

vim.lsp.config("*", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(_)
		on_attach()
	end,
})

local function format()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
end

vim.api.nvim_create_user_command("Format", format, {nargs = 0,
    desc = "format buffer"})
