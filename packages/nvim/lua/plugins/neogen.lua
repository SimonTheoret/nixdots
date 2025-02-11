return {
    "danymat/neogen",
    config = function()
        require('neogen').setup({
            enabled = true,
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention =
                        "numpydoc" -- for a full list of annotation_conventions, see supported-languages below,
                    }
                },
            }
        })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    --
    keys = {

        { '<leader>nf', ":lua require('neogen').generate()<CR>", desc = "Generate documentation" },
    }
}
