return {
    "SUSTech-data/neopyter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "AbaoFromCUG/websocket.nvim",     -- for mode='direct'
    },
    cmd = "Neopyter",
    opts = {
        parser = {
            trim_whitespace = true,
        },
        mode = "direct",
        remote_address = "127.0.0.1:9001",
        file_pattern = { "*.ju.*" },
    },
}
