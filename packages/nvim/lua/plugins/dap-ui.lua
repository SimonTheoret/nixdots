return {
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require("nvim-dap-virtual-text").setup(
                { enabled = false, }
            )
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
        keys = {
            { "<leader>dvt", ":DapVirtualTextToggle<CR>", desc = "DAP virtual text toggle" }
        }
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require('dapui').setup()
        end,
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            {
                "<leader>dut",
                function()
                    require("dapui").toggle()
                end,
                desc = "Toggle dapui"
            },
            {
                "<leader>due",
                function()
                    require("dapui").eval()
                end,
                desc = "Eval dapui"
            }
        },
    } }
