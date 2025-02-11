return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
        require('barbecue').setup({
        })
    end
    ,
}
