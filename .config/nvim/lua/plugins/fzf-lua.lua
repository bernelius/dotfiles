return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostics disable: missing-fields
    opts = {},
    ---@diagnostics enable: missing-fields
    vim.keymap.set("n", "<leader>ff", ":FzfLua global<CR>", { desc = "Fuzzy find files" }),
    vim.keymap.set("n", "<leader>fb", ":FzfLua builtin<CR>", { desc = "Fzf-lua builtins" }),
    vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Fzf-lua live grep" }),
}
