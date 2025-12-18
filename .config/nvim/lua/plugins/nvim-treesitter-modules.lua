local languages = {}

return {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        ensure_installed = languages,
        fold = { enable = false },
        highlight = { enable = false },
        indent = { enable = true },
        incremental_selection = { enable = true },
    },
}
