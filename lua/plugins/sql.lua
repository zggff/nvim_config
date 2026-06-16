return {
    -- {
    --     "ZzurabSiprashvili/run-sql.nvim",
    --     dependencies = {
    --         "ZzurabSiprashvili/run-sql-postgresql-adapter.nvim",
    --     },
    --     config = function()
    --         local sql = require("run-sql")
    --         sql.setup()
    --         sql.register_adapter("postgresql", require("run-sql-postgresql-adapter"))
    --     end,
    -- },
    {
        name = "SqlRunner",
        cmd = "Sql",
        config = function()
            require("misc.sql")
            vim.keymap.set({'v'}, '<CR>', "<cmd>Sql run<cr>")
        end
    }
}
