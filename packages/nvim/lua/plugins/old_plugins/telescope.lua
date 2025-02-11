return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local t = require("telescope")
        t.setup({
            pickers = {
                -- find_files = { theme = "ivy", layout_config = { height = 0.4 } },
                -- git_files = { theme = "ivy", layout_config = { height = 0.4 } },
                -- live_files = { theme = "ivy", layout_config = { height = 0.4 } },
                -- live_grep = { theme = "ivy", layout_config = { height = 0.4 } },
                -- buffers = { theme = "ivy", layout_config = { height = 0.4 } },
                -- help_tags = { theme = "ivy", layout_config = { height = 0.4 } },
                -- vim_options = { theme = "ivy", layout_config = { height = 0.4 } },
                -- commands = { theme = "ivy", layout_config = { height = 0.4 } },
                -- keymaps = { theme = "ivy", layout_config = { height = 0.4 } },
                -- diagnostics = { theme = "ivy", layout_config = { height = 0.4 } },
                -- current_buffer_fuzzy_find = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_references = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_incoming_calls = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_outgoing_calls = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_document_symbols = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_workspace_symbols = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_dynamic_workspace_symbols = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_diagnostics = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_lsp_implementations = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_definitions = { theme = "ivy", layout_config = { height = 0.4 } },
                -- lsp_type_definitions = { theme = "ivy", layout_config = { height = 0.4 } },
            },

            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
                file_browser = {
                    -- theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    respect_gitignore = false,
                    hidden = true,
                }
            }
        })
        -- t.setup({
        --     defaults = {
        --         borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        --     }
        -- })
        t.load_extension('fzf')
        t.load_extension('file_browser')
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
            '<leader>fl',
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = 'Telescope current buffer fuzzy'
        },
        -- {
        --     '<leader>fy',
        --     function() require("telescope").extensions.file_browser.file_browser() end,
        --     desc = 'Telescope file browser'
        -- },

    }
}
