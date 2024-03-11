return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local t = require("telescope")
        -- t.setup({
        --     defaults = {
        --         borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        --     }
        -- })
        t.load_extension('zoxide')
        t.load_extension('projects')
    end,
    keys = {
        {
            '<leader><leader>',
            function() require('telescope.builtin').find_files({ follow = true }) end,
            desc = "Telescope find files"
        },

        {
            '<leader>fg',
            function() require('telescope.builtin').live_grep() end,
            desc = "Telescope live grep"
        },

        {
            '<leader>fd',
            function() require('telescope.builtin').git_files() end,
            desc = "Telescope git files"
        },

        {
            '<leader>fb',
            function() require('telescope.builtin').buffers() end,
            desc = "Telescope buffers"
        },

        {
            '<leader>fh',
            function() require('telescope.builtin').help_tags() end,
            desc = "Telescope help tags"
        },

        {
            '<leader>fk',
            function() require('telescope.builtin').keymaps() end,
            desc = "Telescope keymaps"
        },

        {
            '<leader>fv',
            function() require('telescope.builtin').vim_options() end,
            desc = "Telescope vim options"
        },

        {
            '<leader>fc',
            function() require('telescope.builtin').commands() end,
            desc = "Telescope commands"
        },

        {
            '<leader>fp',
            function() require("telescope").extensions.projects.projects {} end,
            desc = 'Telescope projects'
        },
        {
            '<leader>fz',
            function() require("telescope").extensions.zoxide.list() end,
            desc = 'Telescope zoxide'
        },
        {
            '<leader>fn',
            function()
                local path = "~/org/notes/"
                require('telescope.builtin').find_files({
                    search_dirs =
                    { path }
                })
                vim.cmd("lcd ~/org/notes") -- Locally changes dir
            end,
            desc = "Telescope find notes"
        },
    }
}
