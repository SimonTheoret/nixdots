return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({ "fzf-native" })
    end,
    keys = {
        {
            "<leader><leader>",
            function()
                require('fzf-lua').files()
            end,
            desc = "List files"
        },
        {
            "<leader>fp",
            function()
                require('fzf-lua').files({ cwd = "~/.local/share/chezmoi/" })
            end,
            desc = "List files"
        },
        {
            "<C-x><C-f>",
            function() require("fzf-lua").complete_path() end,
            silent = true,
            desc = "Fuzzy complete path",
            mode = { "n", "v", "i" }
        },
        {
            "<leader>fg",
            function()
                require('fzf-lua').live_grep_native()
            end,
            desc = "Live grep"
        },
        {
            "<leader>fa",
            function()
                require('fzf-lua').lines()
            end,
            desc = "List all buffers' lines"
        },
        {
            "<leader>fl",
            function()
                require('fzf-lua').blines()
            end,
            desc = "List current buffer lines"
        },
        {
            "<leader>fb",
            function()
                require('fzf-lua').buffers()
            end,
            desc = "List buffers"
        },
        {
            "<leader>fw",
            function()
                require('fzf-lua').grep_cword()
            end,
            desc = "Grep word"
        },
        {
            "<leader>fd",
            function()
                require('fzf-lua').git_files()
            end,
            desc = "List git files"
        },
        {
            "<leader>fk",
            function()
                require('fzf-lua').keymaps()
            end,
            desc = "List keymaps"
        },
        {
            "<leader>fk",
            function()
                require('fzf-lua').keymaps()
            end,
            desc = "List keymaps"
        },

    },
}
