local M = {}

---get path for parent directory for path
---@param path string
---@return string
M.parent = function(path)
    local j = 1
    for i = 1, #path - 1 do
        if path:byte(i) == ('/'):byte(1) then
            j = i
        end
    end
    return path:sub(1, j)
end

return M
