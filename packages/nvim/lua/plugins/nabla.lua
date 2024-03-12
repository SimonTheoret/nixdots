return {
    'jbyuki/nabla.nvim',
    config = false,
    keys = {
        {
            "<leader>kj",
            function()
                require("nabla").popup({border = 'single'})
            end,
            desc = "Show latex"
        }
    },
}
