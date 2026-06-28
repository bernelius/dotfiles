return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            djangohtml = { "djlint" },
            htmldjango = { "djlint" },
            typescript = { "eslint" },
            javascript = { "eslint" },
        }
    end,
}
