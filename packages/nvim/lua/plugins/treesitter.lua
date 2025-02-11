return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --adds annotation to remove alerts about missing fields:
    ---@diagnostic disable-next-line: missing-fields
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed =
            { "lua", "vim", "vimdoc",
                "regex", "markdown", "markdown_inline",
                "bash", "latex", "bibtex",
                "css", "html", "javascript",
                "python", "rust", "go",
                "gleam", "elixir" },
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            highlight = {
                enable = true,
                -- disable = { "latex", "bibtex" }
            },
        })
    end
}
