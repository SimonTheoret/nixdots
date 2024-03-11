return {
    "neovim/nvim-lspconfig",
    config = function()
        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        require("neodev").setup({
            -- add any options here, or leave empty to use the default settings
        })
        -- setups LSPs
        local lspconfig = require('lspconfig')

        local on_attach = function(client)
            require 'completion'.on_attach(client)
        end

        -- Set up cmp with lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- python LSP
        lspconfig.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pyright = { autoImportCompletion = true, },
                python = { analysis = { autoSearchPaths = true, diagnosticMode = "workspace" } }
            }
        }
        lspconfig.ruff_lsp.setup {
            on_attach = on_attach,
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` goes here.
                    args = {},
                }
            }
        }

        lspconfig.rust_analyzer.setup { -- rust LSP
            -- Server-specific settings. See `:help lspconfig-setup`
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ['rust-analyzer'] = {
                    completion = {
                        fullFunctionSignatures = { enable = true }
                    },
                    hover = {
                        actions = { enable = true }
                    },
                    check = {
                        command = "clippy"
                    }
                },
            },
        }
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        })
        lspconfig.gopls.setup({ -- go LSP
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        useany = true,
                        unusedvariable = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                    completeUnimported = true,
                    usePlaceholders = true,
                },
            },
        })

        -- Nix lsp
        lspconfig.nil_ls.setup({})

        -- Latex Texlab
        lspconfig.texlab.setup({})

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "diagnostic" })
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "loclist" })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- so gq might work again
                vim.bo[ev.buf].formatexpr = nil

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Lsp declaration", buffer = ev.buf })

                vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end,
                    { desc = "LSP definition", buffer = ev.buf })

                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Lsp informations", buffer = ev.buf })

                vim.keymap.set('n', 'gI', function() require('telescope.builtin').lsp_implementations() end,
                    { desc = "LSP implementations", buffer = ev.buf })

                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Lsp signature", buffer = ev.buf })

                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
                    { desc = "Lsp add workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                    { desc = "Lsp remove workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<space>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { desc = "Lsp list workspace folders", buffer = ev.buf })

                vim.keymap.set('n', '<leader>D', function() require('telescope.builtin').lsp_type_definitions() end,
                    { desc = "LSP type definition", buffer = ev.buf })

                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Lsp rename", buffer = ev.buf })

                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
                    { desc = "Lsp code action", buffer = ev.buf })

                vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end,
                    { desc = "Lsp references", buffer = ev.buf })

                vim.keymap.set('n', '<space>fo', function()
                    vim.lsp.buf.format { async = true }
                end, { desc = "Lsp format buffer", buffer = ev.buf })

                vim.keymap.set('n', '<leader>fi',
                    function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end,
                    { desc = "Lsp workspace symbols", buffer = ev.buf })

                vim.keymap.set('n', '<leader>fj', function() require('telescope.builtin').lsp_document_symbols() end,
                    { desc = "Lsp document symbols", buffer = ev.buf })
            end,
        })
    end,
    lazy = false,
}
