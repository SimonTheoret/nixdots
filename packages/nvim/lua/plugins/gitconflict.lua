return {
    'akinsho/git-conflict.nvim',
    config = function()
        require('git-conflict').setup({ default_mapping = false })
    end,
    keys = {
        { "<leader>gco", ":GitConflictChooseOurs<cr>",   desc = "Conflict choose ours" },
        { "<leader>gct", ":GitConflictChooseTheirs<cr>", desc = "Conflict choose theirs" },
        { "<leader>gcb", ":GitConflictChooseBoth<cr>",   desc = "Conflict choose both" },
        { "<leader>gc0", ":GitConflictChooseNone<cr>",   desc = "Conflict choose None" },
        { "<leader>gcp", ":GitConflictPrevConflict<cr>",   desc = "Previous conflict" },
        { "<leader>gcn", ":GitConflictNextConflict<cr>",   desc = "Next conflict" },
        { "<leader>gca", ":GitConflictListQf<cr>",   desc = "List conflicts" },
    },
}
