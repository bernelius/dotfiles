require("mason-tool-installer").setup({
    auto_update = true,
    debounce_hours = 12,
    ensure_installed = {
        -- lsp
        "eslint",
        "djlsp",
        "tailwindcss",
        "jdtls",
        "lua_ls",
        "ts_ls",
        "clangd",
        "html",
        "bashls",
        "cssls",
        "ruff",
        "pyright",
        "jsonls",
        "postgres_lsp",
        "hyprls",
        "ginko_ls",
        "kotlin_lsp",
        "taplo",
        "systemd_lsp",
        "just",
        "marksman",
        -- format/lint
        "djlint",
        "beautysh",
        "jq",
        "pgformatter",
        "prettierd",
        "stylua",
    },
})

require("mason-lspconfig").setup({
    automatic_enable = {
        exclude = {
            "kotlin_lsp",
        },
    },
})
