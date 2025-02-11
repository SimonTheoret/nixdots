return {
    'mfussenegger/nvim-dap-python',
    config = function()
        require("dap-python").setup("python3")
        -- If using the above, then `python -m debugpy --version`
        -- must work in the shell
    end,
    lazy = true,
}
