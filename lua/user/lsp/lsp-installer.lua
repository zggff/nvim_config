local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "rust_analyzer" then
		local rustopts = {
			tools = {
				autoSetHints = true,
				hover_with_actions = false,
				inlay_hints = {
					show_parameter_hints = true,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {
				settings = {
					["rust-analyzer"] = {
						completion = {
							postfix = {
								enable = false,
							},
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			}),
		}
		require("rust-tools").setup(rustopts)
		server:attach_buffers()
		return
	end

	if server.name == "clangd" then
		-- opts = vim.tbl_deep_extend("force", {
		-- 	cmd = {
		-- 		"clangd",
		-- 		"--background-index",
		-- 		"-j=12",
		-- 		"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
		-- 		"--clang-tidy",
		-- 		"--clang-tidy-checks=*",
		-- 		"--all-scopes-completion",
		-- 		"--cross-file-rename",
		-- 		"--completion-style=detailed",
		-- 		"--header-insertion-decorators",
		-- 		"--header-insertion=iwyu",
		-- 		"--pch-storage=memory",
		-- 	},
		-- }, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
