vim.o.foldcolumn = "1"
vim.o.foldenable = true

require("foldtext").setup({
	styles = {
		default = {
			{
				kind = "section",
				output = function(buffer, window)
					local next_line = table.concat(vim.fn.getbufline(buffer, vim.v.foldstart ))
					local width = vim.api.nvim_win_get_width(window)
					local textoff = vim.fn.getwininfo(window)[1].textoff

					width = width - textoff

					local size = (vim.v.foldend - vim.v.foldstart) + 1

					return {
						{ next_line, "@comment"},
						{ " 󰁂 ", "@comment" },
						{ tostring(size), "@number" },
					}
				end,
			},
		},
	},
})
