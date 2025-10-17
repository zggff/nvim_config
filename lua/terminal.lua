local M = {}

--- Displays text in a floating window.
--- @param text (string) Command to execute
--- @param title (string) Window title
local function display(text, title)
    local buf = vim.api.nvim_create_buf(false, true)
    local ui = vim.api.nvim_list_uis()[1]

    local width = math.floor(ui.width / 2)
    local height = math.floor(ui.height / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        col = ui.width / 2 - width / 2,
        row = ui.height / 2 - height / 2,
        width = width,
        height = height,
        focusable = true,
        border = "rounded",
        title_pos = 'center',
        title = title,
    })

    local keys = { "q", "<Esc>" }
    for _, k in pairs(keys) do
        vim.keymap.set({ "n", "i" }, k,
            function()
                vim.api.nvim_win_close(win, true)
                vim.api.nvim_buf_delete(buf, {
                    force = true
                })
            end,
            { buffer = buf })
    end

    local term = vim.api.nvim_open_term(buf, { force_crlf = true })
    vim.api.nvim_set_current_win(win)
    vim.api.nvim_chan_send(term, text)
end

--- Runs a command and displays its result in a floating window.
--- @param args (string[]) Command to execute
--- @param title (string) Window title
local function run(args, title)
    local res = vim.system(args):wait()
    display(res.stderr .. "\n" .. res.stdout, title)
end

M.run = run
M.display = run

return M
