return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup {
            filesystem = {
            filtered_items = {
              visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
              hide_dotfiles = false,
              hide_gitignored = true,
            },
            window = {
                position = "right"
            }
        }
    }
    end,
    keys =  {
	    {'<leader>po', ":Neotree toggle <CR>", desc = "neotree"},
    },
}
