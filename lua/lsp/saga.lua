local saga = require("lspsaga")

saga.init_lsp_saga({
    move_in_saga = { prev = "<C-k>", next = "<C-j>" },
    finder_action_keys = {
        open = "<CR>",
    },
    code_action_lightbulb = {
        enable = true,
        enable_in_insert = false,
        cache_code_action = true,
        sign = true,
        update_time = 150,
        sign_priority = 20,
        virtual_text = false,
    },
    -- use enter to open file with definition preview
    definition_action_keys = {
        edit = "<CR>",
    },
})
