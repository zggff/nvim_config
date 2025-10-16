local cmp = require("cmp")
local lspkind = require('lspkind')

cmp.setup({
    preselect = cmp.PreselectMode.None,
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" })
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            maxwidth = 40,
            ellipsis_char = "...",
            mode = 'symbol',
        }),
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "neopyter" },
    },
})
