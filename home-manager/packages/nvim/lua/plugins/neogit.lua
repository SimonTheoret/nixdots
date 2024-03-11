return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function ()
        local neogit = require("neogit")
        neogit.setup{
            mappings = {
                commit_editor = {
                    ["<leader><localleader>c"] = "Submit",
                    ["<leader><localleader>k"] = "Abort"
                },
                rebase_editor = {
                    ["<leader><localleader>c"] = "Submit",
                    ["<leader><localleader>k"] = "Abort"
                },
            }
    }
    end,
    keys = {
        {
            "<leader>g/",
            function ()
                require('neogit').open()
            end,
            desc = "Neogit"
        },
    },
}
