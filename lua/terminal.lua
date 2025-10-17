local M = {}

---Adds ascii escape codes to colorise text
---@param text string
---@param color "none" | "red" | "green" | "black"
---@return string
local function colorise(text, color)
    local colors = {
        ["none"] = "[0m",
        ["black"] = "[30m",
        ["red"] = "[31m",
        ["green"] = "[32m",
        ["yellow"] = "[33m",
        ["blue"] = "[34m",
        ["purple"] = "[35m",
        ["cyan"] = "[36m",
        ["white"] = "[37m",
    }
    return colors[color] .. text .. colors["none"]
end

--- Displays text in a floating window.
--- @param title (string) Window title
--- @return integer
local function display(title)
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
        title_pos = "center",
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

    local term = vim.api.nvim_open_term(buf, {})
    vim.api.nvim_set_current_win(win)
    return term
end

--- Runs a command and displays its result in a floating window.
--- @param args (string[]) Command to execute
--- @param title (string) Window title
local function run(args, title)
    local term = display(title)
    vim.system(args, {
        stdout = function(err, data)
            assert(not err, err)
            if data then
                vim.defer_fn(function()
                    vim.api.nvim_chan_send(term, colorise(data, "none"))
                end, 0)
            end
        end,
        stderr = function(err, data)
            assert(not err, err)
            if data then
                vim.defer_fn(function()
                    vim.api.nvim_chan_send(term, colorise(data, "red"))
                end, 0)
            end
        end,
        text = false
    })
end

M.run = run
M.display = run
M.colorise = colorise

return M
