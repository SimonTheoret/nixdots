return {
    "sindrets/diffview.nvim",
    config = true,
    keys = {
        { "<leader>gd", ":DiffviewOpen<cr>",          desc = "Open diff view" },
        { "<leader>gh", ":DiffviewFileHistory %<cr>", desc = "Open diff current file history" },
        { "<leader>gH", ":DiffviewFileHistory <cr>",  desc = "Open diff files history" },
        { "<leader>gq", ":DiffviewClose <cr>",        desc = "Exit diff view" },
    },
}
