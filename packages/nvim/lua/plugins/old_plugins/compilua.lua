local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local M = {}

local popup_options = {
    position = "50%",
    size = {
        width = 80,
    },
    border = {
        style = "single",
        text = {
            top = "[Compile]",
            top_align = "center",
        },
    },
    win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
}

local run = function(cmd)
    vim.cmd('bo split')
    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buffer)
    vim.api.nvim_win_set_height(0, 20)
    vim.api.nvim_buf_set_option(buffer, "modifiable", false)
    local input = string.format("term zsh -ic '%s'", cmd)
    vim.cmd(input)
    vim.keymap.set({"n", "i"}, "q", ":bd<CR>", {buffer = buffer})
end

New_default_completion_compilua = ""

local compilua = function()
    local def
    if New_default_completion_compilua ~= "" then
        def = New_default_completion_compilua
    else
        def = "make "
    end
    local input = Input(popup_options, {
        prompt = "Compilation: ",
        default_value = def,
        on_submit = function(user_input)
            run(user_input)
            New_default_completion_compilua = user_input
        end
    })
    -- mount/open the component
    input:mount()
    --
    -- unmount component when cursor leaves buffer
    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

local recompilua = function()
    local def
    if New_default_completion_compilua ~= "" then
        def = New_default_completion_compilua
    else
        def = "make "
    end
    run(def)
end

M.compilua = compilua
M.recompilua = recompilua


return M
