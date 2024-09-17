require("project_nvim").setup({
    active = true,
    detection_methods = { "pattern" },
    patterns = { "justfile", ".git", "makefile" },
})

local status, telescope = pcall(require, "telescope")
if not status then
    return
end

telescope.load_extension("projects")
