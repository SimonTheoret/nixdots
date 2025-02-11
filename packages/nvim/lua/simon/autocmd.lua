-- List of autocommands

-- Add shebang in shell scripts
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = { "*.sh" },
    callback = function(_)
        vim.api.nvim_buf_set_lines(0, 0, 0, true, { "#!/usr/bin/env sh" })
    end
})
