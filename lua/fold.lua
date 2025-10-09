FoldText = function()
	local buffer = vim.api.nvim_get_current_buf()
	local next_line = table.concat(vim.fn.getbufline(buffer, vim.v.foldstart))
	local size = (vim.v.foldend - vim.v.foldstart) + 1
	return {
		{ next_line, "" },
		{ " 󰁂 ", "@number" },
		{ tostring(size), "@number" },
	}
end

function HighlightedFoldtext()
	local pos = vim.v.foldstart
	local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang)
	if parser == nil then
		return vim.fn.foldtext()
	end
	local query = vim.treesitter.query.get(parser:lang(), "highlights")
	if query == nil then
		return vim.fn.foldtext()
	end

	local tree = parser:parse({ pos - 1, pos })[1]
	local result = {}

	local line_pos = 0

	local prev_range = nil
	for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
		local name = query.captures[id]
		local start_row, start_col, end_row, end_col = node:range()
		if start_row == pos - 1 and end_row == pos - 1 then
			local range = { start_col, end_col }
			if start_col > line_pos then
				table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
			end
			line_pos = end_col
			local text = vim.treesitter.get_node_text(node, 0)
			if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
				result[#result] = { text, "@" .. name }
			else
				table.insert(result, { text, "@" .. name })
			end
			prev_range = range
		end
	end
	local size = (vim.v.foldend - vim.v.foldstart) + 1
	table.insert(result, { "  󰁂 ", "@number" })
	table.insert(result, { tostring(size), "@number" })
	return result
end

vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.fillchars = "fold: "
vim.o.foldtext = "v:lua.HighlightedFoldtext()"

vim.api.nvim_set_hl(0, "Folded", { bg = "black" })

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
	end,
})
