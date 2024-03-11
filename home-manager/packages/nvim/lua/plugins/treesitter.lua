return {"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    --adds annotation to remove alerts about missing fields:
---@diagnostic disable-next-line: missing-fields
    config = function() require('nvim-treesitter.configs').setup ({
        auto_install = true,
        highlight = {
            enable = true,
            disable = {"latex", "bibtex"}
        },
    })
    end



}

