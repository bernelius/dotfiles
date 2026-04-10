vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- Delete without affecting registers
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')

-- x cuts to clipboard in visual mode, deletes into void otherwise
vim.keymap.set("v", "x", '"+x')
vim.keymap.set("n", "x", '"_x')
-- big X yanks the whole line super hard, removing it in the process
vim.keymap.set("n", "X", '"+dd')

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("n", "<leader><Left>", ":bprev<CR>")
vim.keymap.set("n", "<leader><Down>", ":blast<CR>")
vim.keymap.set("n", "<leader><Up>", ":bfirst<CR>")
vim.keymap.set("n", "<leader><Right>", ":bnext<CR>")
vim.keymap.set("n", "<leader>h", ":bprev<CR>")
vim.keymap.set("n", "<leader>j", ":blast<CR>")
vim.keymap.set("n", "<leader>k", ":bfirst<CR>")
vim.keymap.set("n", "<leader>l", ":bnext<CR>")

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
vim.keymap.set("n", "tk", function()
    vim.diagnostic.jump({ count = -1 })
end, { silent = true, desc = "Previous diagnostic" })

vim.keymap.set("n", "tj", function()
    vim.diagnostic.jump({ count = 1 })
end, { silent = true, desc = "Next diagnostic" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
--projectionist
vim.keymap.set("n", "<leader>a", ":A<CR>")
