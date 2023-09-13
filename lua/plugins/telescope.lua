local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup({
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({
                -- even more opts
            }),
        },
        lsp_handlers = {
            lsp_handlers = {
                disable = {},
                location = {
                    telescope = {},
                    no_results_message = "No references found",
                },
                symbol = {
                    telescope = {},
                    no_results_message = "No symbols found",
                },
                call_hierarchy = {
                    telescope = {},
                    no_results_message = "No calls found",
                },
                code_action = {
                    -- telescope = {},
                    telescope = require("telescope.themes").get_dropdown({}),
                    no_results_message = "No code actions available",
                    prefix = "",
                },
            },
        },
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("ui-select")
