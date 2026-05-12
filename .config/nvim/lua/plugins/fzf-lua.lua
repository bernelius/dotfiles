return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            winopts = {
                height = 1,
                width = 1,
                row = 0.35,
                col = 0.5,
                border = "single",
            },
        })
    end,
    opts = {},
    vim.keymap.set("n", "<leader>ff", ":FzfLua global<CR>", { desc = "Fuzzy find files" }),
    vim.keymap.set("n", "<leader>fb", ":FzfLua builtin<CR>", { desc = "Fzf-lua builtins" }),
    vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Fzf-lua live grep" }),
    vim.keymap.set("x", "<leader>fc", ":FzfLua grep_visual<CR>", { desc = "Fzf-lua live grep for visual selection" }),
    vim.keymap.set("n", "<leader>fc", ":FzfLua grep_cword<CR>", { desc = "Fzf-lua live grep for word under cursor" }),
    vim.keymap.set("n", "<leader>fk", ":FzfLua keymaps<CR>", { desc = "Fzf-lua keymaps" }),
}
