return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
---@diagnostic disable-next-line: missing-fields
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end,
}
