vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern={"*.ju.py"},
    command=[[
        set foldmethod=syntax
        syn region myFold start="# %%" end="\n\n\n" transparent fold
    ]]
})
