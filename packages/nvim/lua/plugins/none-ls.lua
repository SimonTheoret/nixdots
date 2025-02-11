return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- generic
                null_ls.builtins.diagnostics.trail_space,
                -- go
                null_ls.builtins.formatting.golines,
                null_ls.builtins.formatting.goimports_reviser,
                null_ls.builtins.formatting.gofumpt,        -- stricter than gofmt
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.code_actions.gomodifytags, -- modify tags easily
                null_ls.builtins.code_actions.impl,         -- generate method stubs for interfaces implementation
                -- python
                null_ls.builtins.formatting.isort.with({
                    extra_args = {
                        "--profile", "black"
                    }
                }),
                -- nix
                null_ls.builtins.formatting.nixfmt,

                -- bash
                null_ls.builtins.formatting.shfmt,

                --cmake
                null_ls.builtins.formatting.cmake_format,

                --c/c++
                null_ls.builtins.formatting.clang_format,

                --web
                null_ls.builtins.formatting.prettier
            }
        })
    end,
    lazy = false,
}
