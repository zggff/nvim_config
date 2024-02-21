local status_ok, legendary = pcall(require, "legendary")
if not status_ok then
    return
end

legendary.setup({
    config = {
        which_key = {
            -- Automatically add which-key tables to legendary
            -- see ./doc/WHICH_KEY.md for more details
            auto_register = true,
            mappings = {},
            opts = {},
            -- controls whether legendary.nvim actually binds they keymaps,
            -- or if you want to let which-key.nvim handle the bindings.
            -- if not passed, true by default
            do_binding = true,
        },
    }
})
