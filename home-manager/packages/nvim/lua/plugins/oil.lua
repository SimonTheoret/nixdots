return {
    'stevearc/oil.nvim',
    config = true,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>to",
            ":Oil<CR> --float .",
            desc = "Toggle Oil"
        }
    },
}
