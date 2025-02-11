return {
    'akinsho/toggleterm.nvim',
    config = true,
    keys = {
        { "<leader>tt", ":ToggleTerm<CR>", desc = "Toggle terminal" },
        { "<leader>tn", ":ToggleTerm direction=tab<CR>", desc = "Toggle terminal as new tab"},
    }
}
