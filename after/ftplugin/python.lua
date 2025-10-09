vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.ju.py" },
	callback = function()
		vim.o.foldlevel = 0
		vim.cmd([[
            set foldmethod=syntax
            syn region myFold start="# %%" end="\n\n\n" transparent fold
        ]])
	end,
})
