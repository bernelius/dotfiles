vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
-- Use system clipboard for yanking
vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })

-- Delete without affecting registers
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })

-- x cuts to clipboard in visual mode, deletes into void otherwise
vim.keymap.set("v", "x", '"+x', { noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
-- big X yanks the while line super hard, removing it in the process
vim.keymap.set("n", "X", '"+dd', { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader><Left>", ":bnext<CR>")
vim.keymap.set("n", "<leader><Down>", ":blast<CR>")
vim.keymap.set("n", "<leader><Up>", ":bfirst<CR>")
vim.keymap.set("n", "<leader><Right>", ":bprev<CR>")
vim.keymap.set("n", "<leader>h", ":bprev<CR>")
vim.keymap.set("n", "<leader>j", ":blast<CR>")
vim.keymap.set("n", "<leader>k", ":bfirst<CR>")
vim.keymap.set("n", "<leader>l", ":bprev<CR>")

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

vim.keymap.set({ "n", "v" }, "<leader>dt", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set({ "n", "v" }, "<leader>df", vim.diagnostic.open_float)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<BS>", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gf", vim.lsp.buf.format, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
