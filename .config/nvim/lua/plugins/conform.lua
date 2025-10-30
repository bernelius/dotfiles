return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                markdown = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                htmldjango = { "djlint" },
                djangohtml = { "djlint" },
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
        require("conform").formatters = {
            stylua = {
                indent_type = "Spaces",
                indent_width = 2,
            },
        }
    end,
}
