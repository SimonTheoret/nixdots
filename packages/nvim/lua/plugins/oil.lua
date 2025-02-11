return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup {
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            delete_to_trash = true
        }
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>fo",
            ":Oil<CR> --float .",
            desc = "Toggle Oil"
        }
    },
}
