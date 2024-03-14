-- List of autocommands


-- remap for neorg + textwidht, foldlevel, conceallevel
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.norg" },
    callback = function(_)
        vim.api.nvim_buf_set_keymap(0, "n", "<tab>", "za", { desc = "Toggle fold" }) -- cute remap for neorg
        vim.bo.textwidth = 80
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end
})

-- markdown files set textwidth, conceallevel
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.markdown", "*.md" },
    callback = function(_)
        vim.bo.textwidth = 80
        vim.wo.conceallevel = 2
    end
})


-- Add shebang in shell scripts
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = { "*.sh" },
    callback = function(_)
        vim.api.nvim_buf_set_lines(0, 0, 0, true, { "#!/usr/bin/env sh" })
    end
})
