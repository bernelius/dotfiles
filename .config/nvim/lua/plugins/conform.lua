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
                yaml = { "prettierd" },
                htmldjango = { "djlint" },
                djangohtml = { "djlint" },
                lua = { "stylua" },
                sql = { "pg_format" },
                json = { "jq" },
                bash = { "beautysh" },
                sh = { "beautysh" },
                zsh = { "beautysh" },
                kotlin = { "ktlint" },
            },
            -- format_on_save = {
            --     timeout_ms = 2000,
            --     async = true,
            --     lsp_format = "fallback",
            -- },
            format_after_save = {
                lsp_format = "fallback",
            },
        })
        require("conform").formatters = {
            stylua = {
                indent_type = "Spaces",
                indent_width = 4,
            },
            ktlint = {
                prepend_args = { "--format" },
            },
        }
    end,
}
