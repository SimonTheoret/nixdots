return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_theme = { "dark" }


        vim.api.nvim_create_autocmd({ "BufRead" }, {
            pattern = { "*.md", "*.markdown" },
            callback = function(_)
                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>pt", ":MarkdownPreviewToggle<CR>",
                    { desc = "Toggle markdown preview" })

                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>pp", ":MarkdownPreview<CR>",
                    { desc = "Preview markdown" })

                vim.api.nvim_buf_set_keymap(0, "n", "<localleader>pp", ":MarkdownPreviewStop<CR>",
                    { desc = "Stop preview markdown" })
            end
        })
    end,
    ft = { "markdown" },
}
