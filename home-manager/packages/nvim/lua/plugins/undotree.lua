return {
    'mbbill/undotree',
    lazy = true,
    keys = { { '<leader>cu', function() vim.cmd.UndotreeToggle() end, { desc = "Undotree Toggle" } } },
}
