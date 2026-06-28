return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 999,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            --flavour = "latte",
            color_overrides = {
                mocha = {
                    base = "#121212",
                    mantle = "#121212",
                    crust = "#000000",
                },
                latte = {
                    base = "#ffffff",
                    mantle = "#ffffff",
                    crust = "#ffffff",
                },
            },
        })
    end,
}
