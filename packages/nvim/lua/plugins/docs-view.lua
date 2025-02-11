return {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
        position = "bottom",
    },
    keys = {
        {"<leader>kd", ":DocsViewUpdate<cr>", desc = "Docs view toggle" },
    },
}
