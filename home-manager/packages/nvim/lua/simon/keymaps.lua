-- Useful keymaps:
local vmap = vim.keymap

-- Move selection up or down
vmap.set("v", "J", ":m '>+1<CR>gv=gv")
vmap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor stays in place during moving line
vmap.set("n", "J", "mzJ`z")

-- Cursor is centered during Ctrl+u/Ctrl+d
vmap.set("n", "<C-d>", "<C-d>zz")
vmap.set("n", "<C-u>", "<C-u>zz")

-- Searched for term stays in middle of screen during navigation)
vmap.set("n", "n", "nzzzv")
vmap.set("n", "N", "Nzzzv")

-- Going down a page keeps the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy the clipboard content into system clipboard
vmap.set({ "n", "v" }, "<leader>y", [["+y]],
    { desc = "Copy clipboard into system clipboard" })
vmap.set("n", "<leader>Y", [["+Y]],
    { desc = "Copy clipboard into system clipboard with overwrite" })

-- Modify the word under the cursor in the whole file
vmap.set("n", "<leader>mod",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Modify word in whole file" })

-- Insert blank lines
vmap.set("n", "<leader>o", "o<Esc>k", { desc = "Whitespace under cursor" })
vmap.set("n", "<leader>O", 'O<Esc>j', { desc = "Whitespace above cursor" })

vmap.set("n", "<leader>cd", ":cd %:h<CR>", { desc = "Make file's path as working dir" })

vmap.set("n", "<tab>", "%", { desc = "Switch delimiters" })

vmap.set("n", "<leader>cc", function() require("simon.compilua").compilua() end, { desc = "Fast compile" })

vmap.set("n", "<leader>sr", function() require("simon.neosearch").search() end, { desc = "Search and replace" })

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
vmap.set("n", "<leader>cln", [[:%s/\s\+$//e<cr>]], { desc = "Clean trailing whitespaces" })

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]],
    { desc = "Open link in browser" })

vmap.set("n", "<leader>na",
    function()
        vim.cmd('e' .. '~/org/agenda/agenda.md')
    end,
    { desc = "Open agenda" })

-- Git signs
