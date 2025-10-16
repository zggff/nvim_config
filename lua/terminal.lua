local M = {}

--- Runs a command and displays its result in a floating window.
--- @param args (string[]) Command to execute
--- @param title (string) Window title
local function run(args, title)
    local buf = vim.api.nvim_create_buf(false, true)
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local new_width = math.floor(width / 2)
    local new_height = math.floor(height / 2)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        col = (width - 1 - new_width) / 2,
        row = (height - 1 - new_height) / 2,
        width = new_width,
        height = new_height,
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
    local res = vim.system(args):wait()
    vim.api.nvim_chan_send(term, res.stderr)
    vim.api.nvim_chan_send(term, res.stdout)
end

M.run = run

return M
