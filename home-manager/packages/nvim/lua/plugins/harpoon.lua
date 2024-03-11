return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
        {"<leader>aa", function() require("harpoon"):list():append() end, desc = "Harpoon append"},
            {"<leader>am", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end},
            {"<A-1>", function() require("harpoon"):list():select(1) end},
            {"<A-2>", function() require("harpoon"):list():select(2) end},
            {"<A-3>", function() require("harpoon"):list():select(3) end},
            {"<A-4>", function() require("harpoon"):list():select(4) end},
            {"<A-%>", function() require("harpoon"):list():select(5) end},

    }
}
