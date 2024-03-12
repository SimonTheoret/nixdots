local M = {}

local search = function()
    local search_for = function(searchedFor)
        if searchedFor == nil or searchedFor == "" then
            print("No input to search for")
            return
        end
        vim.ui.input({ prompt = "replace by: ", default = nil }, function(replacedWith)
            if replacedWith == nil or replacedWith == "" then
                print("No input to replace with")
                return
            end
            local base = "%s/"
            local ending = "gc"
            local searchedString = searchedFor .. "/"
            local replacedString = replacedWith .. "/"
            local total = base .. searchedString .. replacedString .. ending
            vim.cmd(total)
        end
        )
    end
    vim.ui.input({ prompt = "search for: ", default = nil }, search_for)
end

M.search = search

return M
